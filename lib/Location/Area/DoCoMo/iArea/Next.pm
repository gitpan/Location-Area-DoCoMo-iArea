package Location::Area::DoCoMo::iArea::Next;

use strict;

sub seek
{
  shift;
  seek DATA,0,0;
  my ($aid,$said) = @_;
  my @next;
  while (my $line = <DATA>)
  {
    if ($line =~ /^$aid\-$said,[^,]+,([-\d,]*)$/)
    {
      if ($1)
      {
        @next = split(/,/,$1);
      }
      else
      {
        @next = ();
      }
      last;
    }
  }
  return \@next;
}

1;
__DATA__
001-00,hokkaido,001-01,002-01,002-02
001-01,hokkaido,001-00,002-01
002-01,hokkaido,001-00,001-01,002-02,002-17,002-22,002-23
002-02,hokkaido,001-00,002-01,002-03,002-04,002-05,002-22,003-00
002-03,hokkaido,002-02,002-05,002-23,003-00,003-02
002-04,hokkaido,002-02,003-00,005-00
002-05,hokkaido,002-02,002-03,002-19,002-21,002-22,002-23
002-06,hokkaido,002-07,002-10,002-11,002-13
002-07,hokkaido,002-06,002-08,002-10,002-11,002-12
002-08,hokkaido,002-07,002-09,002-11,002-12
002-09,hokkaido,002-08,002-11,002-12,002-18,002-19
002-10,hokkaido,002-06,002-07,002-12,002-13,002-16,002-17,002-22
002-11,hokkaido,002-06,002-07,002-08,002-09,002-15,002-19,002-20
002-12,hokkaido,002-07,002-08,002-09,002-10,002-18,002-22
002-13,hokkaido,002-06,002-10,002-14,002-15,002-16
002-14,hokkaido,002-13,002-15,002-16,002-17,002-23
002-15,hokkaido,002-11,002-13,002-14,002-20,002-23
002-16,hokkaido,002-10,002-13,002-14,002-17
002-17,hokkaido,002-01,002-10,002-14,002-16,002-22,002-23
002-18,hokkaido,002-09,002-12,002-19,002-22
002-19,hokkaido,002-05,002-09,002-11,002-18,002-20,002-21,002-22
002-20,hokkaido,002-11,002-15,002-19,002-21,002-23
002-21,hokkaido,002-05,002-19,002-20,002-23
002-22,hokkaido,002-01,002-02,002-05,002-10,002-12,002-17,002-18,002-19
002-23,hokkaido,002-01,002-03,002-05,002-14,002-15,002-17,002-20,002-21,003-02
003-00,hokkaido,002-02,002-03,002-04,003-01,003-02,004-00,005-00
003-01,hokkaido,003-00,003-02,004-00
003-02,hokkaido,002-03,002-23,003-00,003-01
004-00,hokkaido,003-00,003-01,005-00,006-00,006-01
005-00,hokkaido,002-04,003-00,004-00,006-00
006-00,hokkaido,004-00,005-00,006-01
006-01,hokkaido,004-00,006-00
007-00,touhoku,008-00,009-00,015-00,020-00,021-00
008-00,touhoku,007-00,009-00,010-00,013-00,015-00
009-00,touhoku,007-00,008-00,010-00,020-00
010-00,touhoku,008-00,009-00,011-00,012-00,013-00
011-00,touhoku,010-00,012-00
012-00,touhoku,010-00,011-00,013-00
013-00,touhoku,008-00,010-00,012-00,014-00,015-00
014-00,touhoku,013-00,015-00,024-00,025-00
015-00,touhoku,007-00,008-00,013-00,014-00,021-00,024-00
016-00,touhoku,016-01,017-00,018-00,019-01,022-00
016-01,touhoku,016-00,017-00,018-00,030-00,031-00,056-00
017-00,touhoku,016-00,016-01,022-00,029-00,031-00,032-00,038-00,040-00,041-00
018-00,touhoku,016-00,016-01,019-00,019-01,056-00
019-00,touhoku,018-00,019-01,020-00,021-00,023-00
019-01,touhoku,016-00,018-00,019-00,022-00,023-00
020-00,touhoku,007-00,009-00,019-00,021-00
021-00,touhoku,007-00,015-00,019-00,020-00,023-00,024-00
022-00,touhoku,016-00,017-00,019-01,023-00,041-00,042-00
023-00,touhoku,019-00,019-01,021-00,022-00,024-00,025-00,042-00
024-00,touhoku,014-00,015-00,021-00,023-00,025-00
025-00,touhoku,014-00,023-00,024-00,042-00
026-00,kanto,027-00,028-00,029-00,033-00,034-00,053-00,072-01
027-00,kanto,026-00,029-00,030-00,053-00,055-00,056-00
028-00,kanto,026-00,029-00,032-00,033-00,037-00
029-00,kanto,017-00,026-00,027-00,028-00,030-00,031-00,032-00
030-00,kanto,016-01,027-00,029-00,031-00,056-00
031-00,kanto,016-01,017-00,029-00,030-00
032-00,kanto,017-00,028-00,029-00,037-00,038-00
033-00,kanto,026-00,028-00,034-00,035-00,036-00,037-00,073-00
034-00,kanto,026-00,033-00,072-01,073-00
035-00,kanto,033-00,036-00,073-00,074-00,102-00,107-00
036-00,kanto,033-00,035-00,037-00,038-00,102-00,103-00,104-00,106-00
037-00,kanto,028-00,032-00,033-00,036-00,038-00
038-00,kanto,017-00,032-00,036-00,037-00,039-00,040-00,106-00
039-00,kanto,038-00,040-00,105-00,106-00,111-00,140-00
040-00,kanto,017-00,038-00,039-00,041-00
041-00,kanto,017-00,022-00,040-00,042-00
042-00,kanto,022-00,023-00,025-00,041-00
043-00,kanto,
044-00,kanto,044-01,045-00,048-00,049-00
044-01,kanto,044-00,049-00,051-00,066-05,067-08
045-00,kanto,044-00,046-00,047-00,048-00
046-00,kanto,045-00,047-00
047-00,kanto,045-00,046-00,048-00
048-00,kanto,044-00,045-00,047-00,048-01,049-00
048-01,kanto,048-00,049-00,050-00
049-00,kanto,044-00,044-01,048-00,048-01,050-00,051-00,052-00
050-00,kanto,048-01,049-00,052-00,054-00
051-00,kanto,044-01,049-00,052-00,053-00,066-05,072-00,072-01,072-02
052-00,kanto,049-00,050-00,051-00,053-00,054-00,055-00
053-00,kanto,026-00,027-00,051-00,052-00,055-00,072-01
054-00,kanto,050-00,052-00,055-00
055-00,kanto,027-00,052-00,053-00,054-00,056-00
056-00,kanto,016-01,018-00,027-00,030-00,055-00
057-00,kanto,057-01,057-03,058-00,058-02
057-01,kanto,057-00,057-03,057-04,057-05,058-00,058-07,059-00
057-02,kanto,057-03,057-04,058-04,064-00,066-00,066-01,067-00
057-03,kanto,057-00,057-01,057-02,057-04,058-02,058-04
057-04,kanto,057-01,057-02,057-03,057-05,063-07,064-00,064-04
057-05,kanto,057-01,057-04,059-00,063-06,063-07,063-08
058-00,kanto,057-00,057-01,058-02,058-05,058-07
058-02,kanto,057-00,057-03,058-00,058-04,058-05,058-06,067-04
058-04,kanto,057-02,057-03,058-02,067-00,067-03,067-04
058-05,kanto,058-00,058-02,058-06,058-07
058-06,kanto,058-02,058-05,058-07,058-08,059-06,067-04,067-06
058-07,kanto,057-01,058-00,058-05,058-06,058-08,059-00,059-02,059-04
058-08,kanto,058-06,058-07,058-09,058-10,059-04,059-06
058-09,kanto,058-08,058-10,059-04,059-05
058-10,kanto,058-08,058-09,059-05,059-06,060-00,060-02
059-00,kanto,057-01,057-05,058-07,059-01,059-02,063-05,063-06
059-01,kanto,059-00,059-02,059-03,062-03,063-05
059-02,kanto,058-07,059-00,059-01,059-03,059-04
059-03,kanto,059-01,059-02,059-04,059-05,062-03
059-04,kanto,058-07,058-08,058-09,059-02,059-03,059-05
059-05,kanto,058-09,058-10,059-03,059-04,060-00,060-01,062-01,062-05
059-06,kanto,058-06,058-08,058-10,060-02,067-06
060-00,kanto,058-10,059-05,060-01,060-02,060-03,060-04,061-01,062-07
060-01,kanto,059-05,060-00,062-05,062-06,062-07
060-02,kanto,058-10,059-06,060-00,060-03,060-04
060-03,kanto,060-00,060-02,060-04
060-04,kanto,060-00,060-02,060-03,061-00,061-01
061-00,kanto,060-04,061-01,078-20,078-21
061-01,kanto,060-00,060-04,061-00,062-07,062-10,078-00,078-21
062-00,kanto,062-01,062-03,062-04,062-05,062-06,062-11,063-02
062-01,kanto,059-05,062-00,062-03,062-05
062-03,kanto,059-01,059-03,062-00,062-01,063-02
062-04,kanto,062-00,062-11,062-13,063-01,063-02,063-09
062-05,kanto,059-05,060-01,062-00,062-01,062-06
062-06,kanto,060-01,062-00,062-05,062-07,062-08,062-11
062-07,kanto,060-00,060-01,061-01,062-06,062-08,062-10,062-15
062-08,kanto,062-06,062-07,062-11,062-15,062-16
062-09,kanto,062-10,062-12,062-15,078-00,079-00
062-10,kanto,061-01,062-07,062-09,062-15,078-00
062-11,kanto,062-00,062-04,062-06,062-08,062-13,062-16
062-12,kanto,062-09,062-14,062-15,062-16,068-00,075-00,079-00
062-13,kanto,062-04,062-11,062-14,063-09,063-10
062-14,kanto,062-12,062-13,062-16,063-10,063-12,068-00
062-15,kanto,062-07,062-08,062-09,062-10,062-12,062-16
062-16,kanto,062-08,062-11,062-12,062-14,062-15
063-00,kanto,063-01,063-02,063-03,063-04
063-01,kanto,062-04,063-00,063-02,063-03,063-08,063-09
063-02,kanto,062-00,062-03,062-04,063-00,063-01,063-04,063-05
063-03,kanto,063-00,063-01,063-04,063-08
063-04,kanto,063-00,063-02,063-03,063-05,063-06,063-08
063-05,kanto,059-00,059-01,063-02,063-04,063-06
063-06,kanto,057-05,059-00,063-04,063-05,063-08
063-07,kanto,057-04,057-05,063-08,064-02,064-03,064-04
063-08,kanto,057-05,063-01,063-03,063-04,063-06,063-07,063-09,064-03,065-01
063-09,kanto,062-04,062-13,063-01,063-08,063-10,063-14,065-01,065-02,065-03
063-10,kanto,062-13,062-14,063-09,063-12,063-14
063-12,kanto,062-14,063-10,063-14,068-00
063-14,kanto,063-09,063-10,063-12,065-03,065-04,068-00,068-01,068-02,070-01
064-00,kanto,057-02,057-04,064-01,064-02,064-04,066-00
064-01,kanto,064-00,065-09,066-00,066-02
064-02,kanto,063-07,064-00,064-03,064-04,065-09
064-03,kanto,063-07,063-08,064-02,065-00,065-01,065-09
064-04,kanto,057-04,063-07,064-00,064-02
065-00,kanto,064-03,065-01,065-02,065-05,065-06,065-07,065-09
065-01,kanto,063-08,063-09,064-03,065-00,065-02
065-02,kanto,063-09,065-00,065-01,065-03,065-04,065-07,065-08
065-03,kanto,063-09,063-14,065-02,065-04
065-04,kanto,063-14,065-02,065-03,065-08,070-01,071-01,071-02
065-05,kanto,065-00,065-06,065-07,065-09,066-03
065-06,kanto,065-00,065-05,065-09
065-07,kanto,065-00,065-02,065-05,065-08
065-08,kanto,065-02,065-04,065-07,066-03,071-02
065-09,kanto,064-01,064-02,064-03,065-00,065-05,065-06,066-02,066-03
066-00,kanto,057-02,064-00,064-01,066-01,066-02,066-03
066-01,kanto,057-02,066-00,066-03,067-00,067-01
066-02,kanto,064-01,065-09,066-00,066-03
066-03,kanto,065-05,065-08,065-09,066-00,066-01,066-02,066-04,066-05,067-01,071-02,072-00
066-04,kanto,066-03,066-05,067-01,067-02,067-08
066-05,kanto,044-01,051-00,066-03,066-04,067-08,072-00
067-00,kanto,057-02,058-04,066-01,067-01,067-03
067-01,kanto,066-01,066-03,066-04,067-00,067-02,067-03,067-05,067-07
067-02,kanto,066-04,067-01,067-07,067-08
067-03,kanto,058-04,067-00,067-01,067-04,067-05
067-04,kanto,058-02,058-04,058-06,067-03,067-05,067-06
067-05,kanto,067-01,067-03,067-04,067-06,067-07
067-06,kanto,058-06,059-06,067-04,067-05,067-07,067-08
067-07,kanto,067-01,067-02,067-05,067-06,067-08
067-08,kanto,044-01,066-04,066-05,067-02,067-06,067-07
068-00,kanto,062-12,062-14,063-12,063-14,068-01,075-00
068-01,kanto,063-14,068-00,068-02,075-00,075-01,077-00
068-02,kanto,063-14,068-01,069-00,070-00,070-01,077-00,077-01
069-00,kanto,068-02,070-00,074-00,077-01
070-00,kanto,068-02,069-00,070-01,071-00,072-01,073-00,074-00
070-01,kanto,063-14,065-04,068-02,070-00,071-00,071-01
071-00,kanto,070-00,070-01,071-01,072-01,072-02
071-01,kanto,065-04,070-01,071-00,071-02,072-02
071-02,kanto,065-04,065-08,066-03,071-01,072-00,072-02
072-00,kanto,051-00,066-03,066-05,071-02,072-02
072-01,kanto,026-00,034-00,051-00,053-00,070-00,071-00,072-02,073-00
072-02,kanto,051-00,071-00,071-01,071-02,072-00,072-01
073-00,kanto,033-00,034-00,035-00,070-00,072-01,074-00
074-00,kanto,035-00,069-00,070-00,073-00,077-01,096-00,107-00
075-00,kanto,062-12,068-00,068-01,075-01,079-00
075-01,kanto,068-01,075-00,076-00,077-00,079-00,083-00
076-00,kanto,075-01,077-00,077-01,083-00,087-00,094-00
077-00,kanto,068-01,068-02,075-01,076-00,077-01
077-01,kanto,068-02,069-00,074-00,076-00,077-00,094-00,096-00
078-00,kanto,061-01,062-09,062-10,078-01,078-17,078-21,079-00,083-00
078-01,kanto,078-00,078-08,078-17,078-19,078-21
078-02,kanto,078-03,078-04,078-07,078-08,078-11,078-20
078-03,kanto,078-02,078-04,078-05,078-06
078-04,kanto,078-02,078-03,078-05,078-07
078-05,kanto,078-03,078-04,078-06,078-07
078-06,kanto,078-03,078-05,078-07,078-09
078-07,kanto,078-02,078-04,078-05,078-06,078-08,078-09,078-12,078-14
078-08,kanto,078-01,078-02,078-07,078-11,078-14,078-17,078-18,078-19
078-09,kanto,078-06,078-07,078-10,078-12,078-13
078-10,kanto,078-09,078-13,080-00,081-00
078-11,kanto,078-02,078-08,078-19,078-20
078-12,kanto,078-07,078-09,078-13,078-14
078-13,kyusyu,078-09,078-10,078-12,078-14,080-00
078-14,kanto,078-07,078-08,078-12,078-13,078-15,078-18,080-00,082-01
078-15,kanto,078-14,078-16,078-18,082-01
078-16,kanto,078-15,078-17,078-18,082-01,083-00,083-01
078-17,kanto,078-00,078-01,078-08,078-16,078-18,083-00
078-18,kanto,078-08,078-14,078-15,078-16,078-17
078-19,kanto,078-01,078-08,078-11,078-20,078-21
078-20,kanto,061-00,078-02,078-11,078-19,078-21
078-21,kanto,061-00,061-01,078-00,078-01,078-19,078-20
079-00,kanto,062-09,062-12,075-00,075-01,078-00,083-00
080-00,kanto,078-10,078-13,078-14,081-00,082-01
081-00,kanto,078-10,080-00
082-00,kanto,082-01,083-01,087-00
082-01,kanto,078-14,078-15,078-16,080-00,082-00,083-01
083-00,kanto,075-01,076-00,078-00,078-16,078-17,079-00,083-01,087-00
083-01,kanto,078-16,082-00,082-01,083-00,087-00
084-00,kanto,
085-00,kanto,
086-00,kanto,
087-00,kanto,076-00,082-00,083-00,083-01,088-00,089-00,093-00,094-00
088-00,kanto,087-00,089-00,093-00,093-02
089-00,kanto,087-00,088-00,090-00,093-02
090-00,tokai,089-00,092-00,093-01,093-02
092-00,tokai,090-00,093-01
093-00,tokai,087-00,088-00,093-01,093-02,094-00,095-00
093-01,tokai,090-00,092-00,093-00,093-02
093-02,tokai,088-00,089-00,090-00,093-00,093-01
094-00,kanto,076-00,077-01,087-00,093-00,095-00,096-00,097-00
095-00,tokai,093-00,094-00,097-00,098-02
096-00,kanto,074-00,077-01,094-00,097-00,098-00,107-00,112-00
097-00,kanto,094-00,095-00,096-00,098-00,098-02
098-00,tokai,096-00,097-00,098-01,098-02,099-00,100-00,112-00
098-01,tokai,098-00,099-00,100-00
098-02,tokai,095-00,097-00,098-00,099-00
099-00,tokai,098-00,098-01,098-02
100-00,tokai,098-00,098-01,101-00,101-01,112-00,123-01
101-00,tokai,100-00,101-01
101-01,tokai,100-00,101-00,123-00,123-01
102-00,kanto,035-00,036-00,103-00,107-00,108-00
103-00,kanto,036-00,102-00,104-00,108-00,109-00
104-00,kanto,036-00,103-00,105-00,106-00,109-00,111-00
105-00,kanto,039-00,104-00,106-00,111-00
106-00,kanto,036-00,038-00,039-00,104-00,105-00
107-00,kanto,035-00,074-00,096-00,102-00,108-00,112-00
108-00,kanto,102-00,103-00,107-00,109-00,112-00
109-00,kanto,103-00,104-00,108-00,110-00,111-00,112-00,113-00
110-00,kanto,109-00,111-00,113-00,126-00
111-00,kanto,039-00,104-00,105-00,109-00,110-00,126-00,139-00,140-00
112-00,kanto,096-00,098-00,100-00,107-00,108-00,109-00,113-00,119-00,122-00,123-01
113-00,kanto,109-00,110-00,112-00,119-00,126-00
114-00,tokai,114-01,114-04,114-06,114-07,114-08,116-00
114-01,tokai,114-00,114-02,114-03,114-04,114-06
114-02,tokai,114-01,114-03,114-04,114-05,114-20
114-03,tokai,114-01,114-02,114-06,114-20,114-26
114-04,tokai,114-00,114-01,114-02,114-05,114-08
114-05,tokai,114-02,114-04,114-08,114-10,114-12,114-20,114-25
114-06,tokai,114-00,114-01,114-03,114-07,114-26,114-27,114-28,114-32
114-07,tokai,114-00,114-06,114-32,116-00,118-00
114-08,tokai,114-00,114-04,114-05,114-09,114-10,116-00
114-09,tokai,114-08,114-10,116-00
114-10,tokai,114-05,114-08,114-09,114-11,114-12,116-00
114-11,tokai,114-10,114-12,114-13,115-00,116-00
114-12,tokai,114-05,114-10,114-11,114-13,114-18,114-19,114-25
114-13,tokai,114-11,114-12,114-14,114-16,114-19,114-24,115-00
114-14,tokai,114-13,114-16,114-17,115-00
114-15,tokai,114-16,114-24,114-29
114-16,tokai,114-13,114-14,114-15,114-17,114-24,114-29,114-31,115-00
114-17,tokai,114-14,114-16,115-00
114-18,tokai,114-12,114-19,114-23,114-24,114-25
114-19,tokai,114-12,114-13,114-18,114-24
114-20,tokai,114-02,114-03,114-05,114-21,114-25,114-26
114-21,tokai,114-20,114-22,114-23,114-25,114-26,114-27
114-22,tokai,114-21,114-23,114-24,114-27,114-28
114-23,tokai,114-18,114-21,114-22,114-24,114-25
114-24,tokai,114-13,114-15,114-16,114-18,114-19,114-22,114-23,114-28,114-29
114-25,tokai,114-05,114-12,114-18,114-20,114-21,114-23
114-26,tokai,114-03,114-06,114-20,114-21,114-27
114-27,tokai,114-06,114-21,114-22,114-26,114-28
114-28,tokai,114-06,114-22,114-24,114-27,114-29,114-32
114-29,tokai,114-15,114-16,114-24,114-28,114-30,114-31,114-32
114-30,tokai,114-29,114-31
114-31,tokai,114-16,114-29,114-30,114-32,115-00
114-32,tokai,114-06,114-07,114-28,114-29,114-31,115-00,118-00
115-00,tokai,114-11,114-13,114-14,114-16,114-17,114-31,114-32,118-00,120-00,121-00
116-00,tokai,114-00,114-07,114-08,114-09,114-10,114-11,117-01,118-00,124-00,124-01
117-00,tokai,117-01,117-02,142-00
117-01,tokai,116-00,117-00,124-01,142-00
117-02,tokai,117-00,142-00,158-00,168-00
118-00,tokai,114-07,114-32,115-00,116-00,119-00,121-00,124-00,125-00
119-00,tokai,112-00,113-00,118-00,121-00,122-00,125-00,126-00
120-00,tokai,115-00,121-00,122-00
121-00,tokai,115-00,118-00,119-00,120-00,122-00
122-00,tokai,112-00,119-00,120-00,121-00,123-00,123-01
123-00,tokai,101-01,122-00,123-01
123-01,tokai,100-00,101-01,112-00,122-00,123-00
124-00,tokai,116-00,118-00,124-01,125-00,129-00
124-01,tokai,116-00,117-01,124-00,127-00,129-00,142-00,143-00
125-00,tokai,118-00,119-00,124-00,126-00,129-00
126-00,tokai,110-00,111-00,113-00,119-00,125-00,126-01,129-00,132-00,137-00,138-00,139-00
126-01,tokai,126-00
127-00,hokuriku,124-01,128-00,129-00,143-00,145-00
128-00,hokuriku,127-00,129-00,130-00
129-00,hokuriku,124-00,124-01,125-00,126-00,127-00,128-00,130-00,132-00
130-00,hokuriku,128-00,129-00,131-06,132-00
131-01,hokuriku,131-02,131-04,131-05,133-00,137-00
131-02,hokuriku,131-01,131-03,131-04,131-05,133-00
131-03,hokuriku,131-02,131-04,131-05
131-04,hokuriku,131-01,131-02,131-03,131-05,137-00
131-05,hokuriku,131-01,131-02,131-03,131-04,131-06,132-00,137-00
131-06,hokuriku,130-00,131-05,132-00
132-00,hokuriku,126-00,129-00,130-00,131-05,131-06,137-00
133-00,hokuriku,131-01,131-02,134-00,135-00,136-00,137-00
134-00,hokuriku,133-00,135-00,136-00
135-00,hokuriku,133-00,134-00
136-00,hokuriku,133-00,134-00,137-00,138-00
137-00,hokuriku,126-00,131-01,131-04,131-05,132-00,133-00,136-00,138-00
138-00,hokuriku,126-00,136-00,137-00,139-00,140-00
139-00,hokuriku,111-00,126-00,138-00,140-00
140-00,hokuriku,039-00,111-00,138-00,139-00
141-00,kansai,142-00,144-00,149-07,149-08,149-14,149-21,151-00
142-00,kansai,117-00,117-01,117-02,124-01,141-00,143-00,151-00,158-00
143-00,kansai,124-01,127-00,142-00,144-00,145-00
144-00,kansai,141-00,143-00,145-00,146-00,147-01,149-08
145-00,hokuriku,127-00,143-00,144-00,146-00
146-00,hokuriku,144-00,145-00,147-00,147-01
147-00,kansai,146-00,147-01,148-00,181-00
147-01,kansai,144-00,146-00,147-00,149-08,149-12,149-13,149-15,173-00,173-02,181-00
148-00,kansai,147-00,181-00,182-01,183-00,184-00,186-00
149-00,kansai,149-04,149-05,149-17,149-18,149-19
149-01,kansai,149-03,149-05,149-17,149-19
149-03,kansai,149-01,149-04,149-07,149-08,149-15,149-19,149-20
149-04,kansai,149-00,149-03,149-12,149-13,149-18,149-19,149-20
149-05,kansai,149-00,149-01,149-07,149-14,149-17,149-18,149-21
149-07,kansai,141-00,149-03,149-05,149-08,149-14
149-08,kansai,141-00,144-00,147-01,149-03,149-07,149-15
149-12,kansai,147-01,149-04,149-13,149-18,150-00,173-02
149-13,kansai,147-01,149-04,149-12,149-15,149-20
149-14,kansai,141-00,149-05,149-07,149-21
149-15,kansai,147-01,149-03,149-08,149-13,149-20
149-17,kansai,149-00,149-01,149-05,149-19
149-18,kansai,149-00,149-04,149-05,149-12,149-21,150-00
149-19,kansai,149-00,149-01,149-03,149-04,149-17
149-20,kansai,149-03,149-04,149-13,149-15
149-21,kansai,141-00,149-05,149-14,149-18,150-00,151-00
150-00,kansai,149-12,149-18,149-21,151-00,173-02
151-00,kansai,141-00,142-00,149-21,150-00,153-00,154-00,155-00,158-00,173-02,174-00
152-00,kansai,152-01,152-02,160-00,172-10,172-12
152-01,kansai,152-00,159-00,160-00
152-02,kansai,152-00,155-00,156-00,160-00,172-10,175-00
153-00,kansai,151-00,154-00,155-00
154-00,kansai,151-00,153-00,155-00,174-00,175-00
155-00,kansai,151-00,152-02,153-00,154-00,156-00,158-00,168-00,169-00,175-00
156-00,kansai,152-02,155-00,160-00,161-00,162-00,166-00,167-00,169-00
158-00,tokai,117-02,142-00,151-00,155-00,168-00
159-00,kansai,152-01,160-00,161-00
160-00,kansai,152-00,152-01,152-02,156-00,159-00,161-00
161-00,kansai,156-00,159-00,160-00,162-00
162-00,kansai,156-00,161-00,163-00,164-00,166-00
163-00,kansai,162-00,164-00
164-00,kansai,162-00,163-00,165-00,166-00
165-00,kansai,164-00,166-00
166-00,kansai,156-00,162-00,164-00,165-00,167-00
167-00,tokai,156-00,166-00,169-00
168-00,tokai,117-02,155-00,158-00,169-00
169-00,tokai,155-00,156-00,167-00,168-00,170-00
170-00,tokai,169-00
172-00,kansai,172-02,172-05,172-14,172-20
172-01,kansai,172-03,172-04,172-14,172-15,172-16
172-02,kansai,172-00,172-14,172-15,172-20
172-03,kansai,172-01,172-06,172-15,172-16,172-21
172-04,kansai,172-01,172-14,172-16,172-19
172-05,kansai,172-00,172-13,172-14,172-19,172-20,173-01,176-00
172-06,kansai,172-03,172-17,172-18,172-21
172-08,kansai,172-10,172-17,172-18
172-10,kansai,152-00,152-02,172-08,172-12,172-17,172-18,175-00
172-12,kansai,152-00,172-10,172-13,172-18,172-21
172-13,kansai,172-05,172-12,172-20,172-21,176-00
172-14,kansai,172-00,172-01,172-02,172-04,172-05,172-19
172-15,kansai,172-01,172-02,172-03,172-20,172-21
172-16,kansai,172-01,172-03,172-04,172-17,172-19
172-17,kansai,172-06,172-08,172-10,172-16,172-18,172-19,175-00
172-18,kansai,172-06,172-08,172-10,172-12,172-17
172-19,kansai,172-04,172-05,172-14,172-16,172-17,173-01,173-02,174-00,175-00
172-20,kansai,172-00,172-02,172-05,172-13,172-15,172-21
172-21,kansai,172-03,172-06,172-12,172-13,172-15,172-20
173-00,kansai,147-01,173-01,173-02,176-01,181-00
173-01,kansai,172-05,172-19,173-00,173-02,176-00,176-01
173-02,kansai,147-01,149-12,150-00,151-00,172-19,173-00,173-01,174-00
174-00,kansai,151-00,154-00,172-19,173-02,175-00
175-00,kansai,152-02,154-00,155-00,172-10,172-17,172-19,174-00
176-00,kansai,172-05,172-13,173-01,176-01,177-00
176-01,kansai,173-00,173-01,176-00,177-00,179-06,181-00,182-01
177-00,kansai,176-00,176-01,178-00,179-06
178-00,kansai,177-00,179-06,179-08
179-00,kansai,179-01,179-05
179-01,kansai,179-00,179-02,179-03,179-05
179-02,kansai,179-01,179-03,179-04,179-05,179-06
179-03,kansai,179-01,179-02,179-04
179-04,kansai,179-02,179-03,179-06,179-08
179-05,kansai,179-00,179-01,179-02,179-06,179-09
179-06,kansai,176-01,177-00,178-00,179-02,179-04,179-05,179-07,179-08,179-09,182-01
179-07,kansai,179-06,179-09,180-00,182-00,182-01
179-08,kansai,178-00,179-04,179-06
179-09,kansai,179-05,179-06,179-07,180-00
180-00,kansai,179-07,179-09,182-00
181-00,kansai,147-00,147-01,148-00,173-00,176-01,182-01
182-00,kansai,179-07,180-00,182-01,184-00
182-01,kansai,148-00,176-01,179-06,179-07,181-00,182-00,184-00
183-00,kansai,148-00,184-00,186-00,197-00,198-02
184-00,kansai,148-00,182-00,182-01,183-00
185-00,kansai,
186-00,chugoku,148-00,183-00,186-01,198-02
186-01,chugoku,186-00,186-02,198-02
186-02,chugoku,186-01,191-00,191-01,198-01,198-02,200-01
191-00,chugoku,186-02,191-01
191-01,chugoku,186-02,191-00,191-02,200-01
191-02,chugoku,191-01,191-03,200-01,200-08
191-03,chugoku,191-02,191-04,200-08
191-04,chugoku,191-03,200-02,200-08,205-00,205-01,205-03
191-05,chugoku,
197-00,chugoku,183-00,198-00,198-02
198-00,chugoku,197-00,198-01,198-02,199-00,208-00
198-01,chugoku,186-02,198-00,198-02,199-00,200-01
198-02,chugoku,183-00,186-00,186-01,186-02,197-00,198-00,198-01
199-00,chugoku,198-00,198-01,200-00,200-01,209-00
200-00,chugoku,199-00,200-01,200-06,200-07
200-01,chugoku,186-02,191-01,191-02,198-01,199-00,200-00,200-05,200-07,200-08
200-02,chugoku,191-04,200-03,200-04,200-08,205-03
200-03,chugoku,200-02,200-04,200-05
200-04,chugoku,200-02,200-03,200-05,200-08
200-05,chugoku,200-01,200-03,200-04,200-06,200-07,200-08
200-06,chugoku,200-00,200-05,200-07,216-00
200-07,chugoku,200-00,200-01,200-05,200-06
200-08,chugoku,191-02,191-03,191-04,200-01,200-02,200-04,200-05
205-00,chugoku,191-04,205-01,205-02,205-03
205-01,chugoku,191-04,205-00,205-02
205-02,chugoku,205-00,205-01,223-01,223-02
205-03,chugoku,191-04,200-02,205-00
207-00,shikoku,208-00,209-00,213-00
208-00,shikoku,198-00,207-00,212-00,213-00
209-00,shikoku,199-00,207-00,210-00,213-00
210-00,shikoku,209-00,213-00,216-00
211-00,shikoku,212-00,213-00,214-00
212-00,shikoku,208-00,211-00,213-00
213-00,shikoku,207-00,208-00,209-00,210-00,211-00,212-00,214-00,216-00,220-00
214-00,shikoku,211-00,213-00,220-00,221-00
215-00,shikoku,216-00,217-00,220-00,222-00
216-00,shikoku,200-06,210-00,213-00,215-00,220-00
217-00,shikoku,215-00,218-00,222-00
218-00,shikoku,217-00,222-00
219-00,shikoku,220-00
220-00,shikoku,213-00,214-00,215-00,216-00,219-00,221-00,222-00
221-00,shikoku,214-00,220-00
222-00,shikoku,215-00,217-00,218-00,220-00
223-00,kyusyu,223-01,223-02
223-01,kyusyu,205-02,223-00,223-02,223-03,223-04,223-05
223-02,kyusyu,205-02,223-00,223-01,223-03,223-04
223-03,kyusyu,223-01,223-02,223-04
223-04,kyusyu,223-01,223-02,223-03,223-05,224-04,224-06,225-00,235-00
223-05,kyusyu,223-01,223-04,235-00
224-00,kyusyu,224-01,224-02,224-03
224-01,kyusyu,224-00,224-02,224-04,224-06
224-02,kyusyu,224-00,224-01,224-03,224-04
224-03,kyusyu,224-00,224-02,224-04,224-05,226-00
224-04,kyusyu,223-04,224-01,224-02,224-03,224-06,225-00,226-00
224-05,kyusyu,224-03,226-00,227-00
224-06,kyusyu,223-04,224-01,224-04
225-00,kyusyu,223-04,224-04,225-01,226-00,235-00
225-01,kyusyu,225-00,226-00,234-01,235-00
226-00,kyusyu,224-03,224-04,224-05,225-00,225-01,227-00
227-00,kyusyu,224-05,226-00,229-00,231-00
228-00,kyusyu,
229-00,kyusyu,227-00,231-00
230-00,kyusyu,231-00
231-00,kyusyu,227-00,229-00,230-00,232-00
232-00,kyusyu,231-00
233-00,kyusyu,234-00,244-01
234-00,kyusyu,233-00,234-01,238-00,240-00,243-00
234-01,kyusyu,225-01,234-00,235-00,238-00
235-00,kyusyu,223-04,223-05,225-00,225-01,234-01,236-00,237-00,238-00
236-00,kyusyu,235-00,237-00
237-00,kyusyu,235-00,236-00,238-00,239-00,239-01
238-00,kyusyu,234-00,234-01,235-00,237-00,239-01,240-00
239-00,kyusyu,237-00,239-01
239-01,kyusyu,237-00,238-00,239-00,240-00
240-00,kyusyu,234-00,238-00,239-01,241-00,243-00
241-00,kyusyu,240-00,242-00,243-00,246-00
242-00,kyusyu,241-00,243-00,244-01,244-02,246-00
243-00,kyusyu,234-00,240-00,241-00,242-00,244-01
244-00,kyusyu,244-01,244-02,245-00,246-00
244-01,kyusyu,233-00,242-00,243-00,244-00,244-02
244-02,kyusyu,242-00,244-00,244-01,246-00
245-00,kyusyu,244-00
246-00,kyusyu,241-00,242-00,244-00,244-02
247-00,kyusyu,
248-00,kyusyu,
249-00,kyusyu,250-00
250-00,kyusyu,249-00
251-00,kyusyu,
