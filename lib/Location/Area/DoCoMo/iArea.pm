package Location::Area::DoCoMo::iArea;

################################
#
#  DoCoMo Functions for iArea
#  Location::Area::DoCoMo::iArea
#  

use 5.008;
use strict;
use warnings;
use vars qw($VERSION $AUTOLOAD);
$VERSION = 1.00;

use Carp;
use File::Basename;
use Cwd 'abs_path';
use DBI;
use Location::GeoTool;

sub _dbh
{
	my $dbname = abs_path(dirname(__FILE__))."/iArea/Data.pm";
	return DBI->connect("DBI:SQLite:dbname=$dbname", "", "",{ RaiseError => 1, AutoCommit => 1 });
}

sub _createObject
{
	my $class = shift;
	my ($sql,@sqlarg) = @_;
	my $dbh = $class->_dbh;
	unless ($dbh)
	{
		die "Can't create connection to DB";
	}

	my $sth = $dbh->prepare($sql);
	$sth->execute(@sqlarg);
	my $hash_ref = $sth->fetchrow_hashref;
	$sth->finish;
	$dbh->disconnect;

	return undef unless ($hash_ref);
	bless $hash_ref, $class;
	return $hash_ref;	
}

sub setArea
{
	my $class = shift;
	my ($area,$sub_area) = @_;

	if ($area =~ /^(\d{3})(\d{2})$/)
	{
		$area = $1;
		$sub_area = $2;
	}
	elsif (!(($area =~ /^\d{3}$/) && ($sub_area =~ /^\d{2}$/)))
	{
		return undef;
	}

	return $class->_createObject("SELECT * FROM iarea_area WHERE areaid = ? AND sub_areaid =?",$area,$sub_area);
}

sub setCoordinate
{
	my $class = shift;
	my ($lat,$lon,$usetokyo) = @_;

	if (!(($lat =~ /^(\+|-)\d{10}$/) && ($lon =~ /^(\+|-)\d{10}$/)))
	{
		return undef;
	}
	($lat,$lon) = datumchange($lat,$lon,"+000000",LG_WGS84,LG_TOKYO) unless ($usetokyo);
	($lat,$lon) = map { coordformat($_,LG_FMT,LG_FMT_SEC) * 1000 } ($lat,$lon);

	my @mesh = ();
	my $ab = int($lat / 2400000);
	my $cd = int($lon / 3600000) - 100;
	my $x1 = ($cd +100) * 3600000;
	my $y1 = $ab * 2400000;
	my $e = int(($lat - $y1) / 300000);
	my $f = int(($lon - $x1) / 450000);
	$mesh[0] = $ab.$cd.$e.$f;
	my $x2 = $x1 + $f * 450000;
	my $y2 = $y1 + $e * 300000;
	my $l3 = int(($lon - $x2) / 225000);
	my $m3 = int(($lat - $y2) / 150000);
	my $g = $l3 + $m3 * 2;
	$mesh[1] = $mesh[0].$g;	
	my $x3 = $x2 + $l3 * 225000;
	my $y3 = $y2 + $m3 * 150000;
	my $l4 = int(($lon - $x3) / 112500);
	my $m4 = int(($lat - $y3) / 75000);
	my $h = $l4 + $m4 * 2;
	$mesh[2] = $mesh[1].$h;	
	my $x4 = $x3 + $l4 * 112500;
	my $y4 = $y3 + $m4 * 75000;
	my $l5 = int(($lon - $x4) / 56250);
	my $m5 = int(($lat - $y4) / 37500);
	my $i = $l5 + $m5 * 2;
	$mesh[3] = $mesh[2].$i;	
	my $x5 = $x4 + $l5 * 56250;
	my $y5 = $y4 + $m5 * 37500;
	my $l6 = int(($lon - $x5) / 28125);
	my $m6 = int(($lat - $y5) / 18750);
	my $j = $l6 + $m6 * 2;
	$mesh[4] = $mesh[3].$j;
	my $x6 = $x5 + $l6 * 28125;
	my $y6 = $y5 + $m6 * 18750;
	my $l7 = int(($lon - $x6) / 14062.5);
	my $m7 = int(($lat - $y6) / 9375);
	my $k = $l7 + $m7 * 2;
	$mesh[5] = $mesh[4].$k;

	return $class->_createObject("SELECT a.* FROM iarea_area a, iarea_mesh b WHERE a.areaid = b.areaid AND a.sub_areaid=b.sub_areaid AND (b.mesh = ? OR b.mesh = ? OR b.mesh = ? OR b.mesh = ? OR b.mesh = ? OR b.mesh = ?)",@mesh);
}

sub getNextArea
{
	my $self = shift;
	my $dbh = $self->_dbh;
	my $sth = $dbh->prepare("SELECT id1 AS id FROM iarea_next WHERE id2 = ? UNION SELECT id2 AS id FROM iarea_next WHERE id1 = ?");
	$sth->execute($self->full_areaid,$self->full_areaid);

	my @nextareas = ();
	while (my $s = $sth->fetchrow_hashref)
	{
		my $tmpobj = Location::Area::DoCoMo::iArea->setArea($s->{'id'});
		push (@nextareas,$tmpobj);
	}
	$sth->finish;
	$dbh->disconnect;
	return wantarray() ? @nextareas : \@nextareas;
}

sub AUTOLOAD 
{
	my $self = shift;
	my $method = $AUTOLOAD;
	$method =~ s/.+://;
	my %canaccept = map { $_ => 1 } ("areaid","sub_areaid","name","region","prefecture");
	return if ($method eq "DESTROY");
	if ($canaccept{$method})
	{
		unless (defined($self->{$method}))
		{
			return undef;
		}
		return $self->{$method};
	}
	else
	{
		croak qq{Can't locate object method "$method" via package "Location::Area::DoCoMo::iArea"};
	}
}

sub full_areaid
{
	my $self = shift;	
	return $self->areaid().$self->sub_areaid();
}

sub getAura
{
	my $self = shift;	
	my $usetokyo = shift;
	if (!(defined($self->{"west"})) || !(defined($self->{"south"})) || !(defined($self->{"east"})) || !(defined($self->{"north"})))
	{
		return undef;
	}
	my @sw = map {coordformat($_/1000,LG_FMT_SEC,LG_FMT)} ($self->{"south"}, $self->{"west"});
	my @ne = map {coordformat($_/1000,LG_FMT_SEC,LG_FMT)} ($self->{"north"}, $self->{"east"});
	unless ($usetokyo)
	{
		@sw = datumchange(@sw,"+000000",LG_TOKYO,LG_WGS84);
		@ne = datumchange(@ne,"+000000",LG_TOKYO,LG_WGS84);
	}

	return (@sw[0..1],@ne[0..1]);
}

1;
__END__

=head1 NAME

Location::Area::DoCoMo::iArea - Get NTT DoCoMo's i-Area from i-Area code or Geo coordinate

=head1 SYNOPSIS

  use Location::Area::DoCoMo::iArea;

  #Create object

  # Get i-Area object from Geo coordinate at WGS84 Datum
  $oiArea = Location::Area::DoCoMo::iArea->setCoordinate("+0342039933","+1352151826");
  # or at TOKYO Datum
  $oiArea = Location::Area::DoCoMo::iArea->setCoordinate("+0342039933","+1352151826",1);

  # Get i-Area object from full area code
  $oiArea = Location::Area::DoCoMo::iArea->setArea("152","00");
  # or same
  $oiArea = Location::Area::DoCoMo::iArea->setArea("15200");

  #Get data

  # Get full area code (5digit)
  my $fid = $oiArea->full_areaid();
  # Get main area code (3digit)
  my $pid = $oiArea->areaid();
  # Get sub area code (2digit)
  my $sid = $oiArea->sub_areaid();

  # Get area name (at EUC-JP character code)
  my $name = $oiArea->name();
  # Get prefecture name of this area (at EUC-JP character code)
  my $pref = $oiArea->prefecture();
  # Get region name of this area (at EUC-JP character code)
  my $reg = $oiArea->region();

  # Get south, west, north, east limit of this area at WGS84 Datum
  my ($slim,$wlim,$nlim,$elim) = $oiArea->getAura();
  # Or at TOKYO Datum
  my ($slim,$wlim,$nlim,$elim) = $oiArea->getAura(1);
  # Get i-Area object list which are next to this area
  my @next = $oiArea->getNextArea();

=head1 DESCRIPTION

=head2 EXPORT

None

=head2 CONSTRUCTOR

=head3 setCoordinate

  Create i-Area object from coordinate.
  Coordinate format is pdddmmssnnn.
  (p: plus/minus, d:degree, m:minute, s:second n: millisecond)
  Default datum is WGS84, but you can use TOKYO if you set $utokyo argument as 1.

  Usage:
    $obj = Location::Area::DoCoMo::iArea->setCoordinate($lat,$lon,$utokyo);
  Arguments:
    $lat   : Latitude (North are Positive).
    $lon   : Longitude (East are Positive).
    $utokyo: Set 1 if you want to use TOKYO datum.
  Return Values:
    $obj   : Location::Area::DoCoMo::iArea object. undef if can't bind coprdinate to area.

=head3 setArea

  Create i-Area object from full area code.

  Usage:
    $obj = Location::Area::DoCoMo::iArea->setArea($id,$sid);
  Arguments:
    $id    : Set full area code or main area code
    $lon   : Set sub area code (needed if you give main area code as $id)
  Return Values:
    $obj   : Location::Area::DoCoMo::iArea object. undef if can't bind code to area.

=head2 METHOD

=head3 full_areaid

=head3 areaid

=head3 sub_areaid

  Each method returns full area code, main area code or sub area code.

=head3 name

=head3 prefecture

=head3 region

  Each method returns area name, prefecture name of this area or region name of this area.
  Each return values are described in EUC-JP character code.

=head3 getAura

  Get south, west, north, east limit of this area.
  Method returns WGS84 datum in default, but you can get TOKYO if you set $utokyo argument as 1.

  Usage:
    ($slim,$wlim,$nlim,$elim) = $obj->getAura($utokyo);
  Arguments:
    $utokyo: Set 1 if you want to use TOKYO datum.
  Return Values:
    $slim  : South limit latitude of this area.
    $wlim  : West limit longitude of this area.
    $nlim  : South limit latitude of this area.
    $elim  : East limit longitude of this area.
  Notice:
    NTT DoCoMo provides limit data of all sides in each area at TOKYO datum.
    In WGS84, this function convert two points ($slim,$wlim),($nlim,$elim)
    from TOKYO.
    But, converting from TOKYO to WGS84 is not a linear, so this data may cause inconsistency if you use it in a strict sense.

=head3 getNextArea

  Get i-Area object list which are next to this area.

  Usage:
    @next = $obj->getNextArea();
  Return Values:
    $slim  : i-Area object list of areas next to this area.
  Notice:
    If there is the sea between one area and another, they are not next area.
    This definition is based on NTT DoCoMo's.

=head1 DEPENDENCIES

 DBI
 DBD::SQLite
 Carp
 File::Basename
 Cwd
 Location::GeoTool

=head1 SEE ALSO

 i-Area data in this version is based on NTT DoCoMo's data, publicated in May 15th, 2003.
 You can get original data on 
 http://www.nttdocomo.co.jp/p_s/imode/iarea/iareadata030512.lzh.
 And, next area data is based on NTT DoCoMo's web site,
 http://www.nttdocomo.co.jp/p_s/imode/iarea/iareaweb/iarea_contents.html.
 You should see these site.

 Support this module in SpaceTag Inc. web site : http://www.spacetag.jp/

=head1 AUTHOR

OHTSUKA Ko-hei, E<lt>kotsuka@spacetag.jpE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by SpaceTag INC.,

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
