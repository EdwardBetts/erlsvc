#-
# Copyright 2011 Yakaz. All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 
#    1. Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
# 
#    2. Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY YAKAZ ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL YAKAZ OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

package ErlSvc::Ctl::Command::target::deploy;
use base qw(ErlSvc::Ctl::Command::target);

=head1 NAME

ErlSvc::Ctl::Command::target::deploy - Deploy or update a target system directory

=cut

use strict;
use warnings;
use utf8;

use ErlSvc::Ctl::Exceptions qw(:all);
use ErlSvc::Ctl::Target;

sub desc () {
    return <<'EOF';
This command deploys or update a target system directory. In other
words, it uses rsync(1) to copy the system Erlang root directory to a
directory which will be the root directory of the node.

Using this command on a remote node is not possible.
EOF
}

sub option_spec {
    return (
        ['directory|d=s',  'specify the target system directory'],
        ['from-scratch|f', 'remove existing directory first']
    );
}

sub run {
    my ($self, $opts, @args) = @_;

    my $target_system = ErlSvc::Ctl::Target->new($self);

    my %params = ();

    if ($opts->{'directory'}) {
        $params{'directory'} = $opts->{'directory'};
    }
    if ($opts->{'from_scratch'}) {
        $params{'from_scratch'} = 1;
    }

    my $ret = $target_system->deploy(%params);
    unless ($ret) {
        command_run_failure;
    }

    return;
}

1;
