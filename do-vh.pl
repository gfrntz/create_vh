#!/usr/bin/perl -w

push(@INC,"./");

use strict;
use vh;
chk_dir();

create_vh($user_name,$vh_name);
