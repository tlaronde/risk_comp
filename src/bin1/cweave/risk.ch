% This is the change file for RISK.
% 2017-12-12 Thierry Laronde <tlaronde@polynum.com>
% 2023-07-24 Update to 4.9 [TL]
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1] Changing size of max filename according to stdio.h:FILENAME_MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@x
@d max_file_name_length 60
@y
@d max_file_name_length (FILENAME_MAX+1)
@z

