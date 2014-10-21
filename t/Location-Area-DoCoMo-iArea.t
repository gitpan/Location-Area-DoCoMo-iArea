use Test::More tests => 5;
use lib "./lib"; 
use Location::Area::DoCoMo::iArea;

# test 1: use test
use_ok('Location::Area::DoCoMo::iArea');

# test 2: setCoordinate test
my $iarea = Location::Area::DoCoMo::iArea->setCoordinate("+0350000000","+1350000000");
my ($id,$sub,$name,$reg,$pref) = map { $iarea->$_ } ("areaid","sub_areaid","name","region","prefecture");
ok (($id == "182") && ($sub == "01") && ($name eq "������") && ($reg eq "����") && ($pref eq "ʼ��"));

# test 3: setArea test
$iarea = Location::Area::DoCoMo::iArea->setArea("152","00");
($id,$sub,$name,$reg,$pref) = map { $iarea->$_ } ("areaid","sub_areaid","name","region","prefecture");
ok (($id == "152") && ($sub == "00") && ($name eq "����") && ($reg eq "����") && ($pref eq "���"));

# test 4: getNextArea test
my $nextarea="����/���,����,�����,������,������/����/ʿ��";
my $ok = 1;
foreach ($iarea->getNextArea)
{
	my $name = $_->name;
	$ok &= ($nextarea =~ /$name/);
}
ok ($ok);

# test 5: getAura test
my $realaura="+0342028125+1352201875+0343624375+1353316875";
my $getaura;
foreach ($iarea->getAura(1))
{
	$getaura .= $_;
}
ok ($realaura eq $getaura);
