package Qudo::Hook::Notify::Abort;
use strict;
use warnings;
use base 'Qudo::Hook';

sub hook_point { 'post_work' }

sub load {
    my ($class, $klass) = @_;

    $klass->hooks->{post_work}->{'notify_abort'} = sub {
        my $job = shift;
        if ($job->is_aborted) {
            $klass->plugin->{logger}->emergency(
                sprintf('%s is abort!!',$job->funcname)
            );
        }
    };
}

sub unload {
    my ($class, $klass) = @_;

    delete $klass->hooks->{post_work}->{'notify_abort'};
}


1;
__END__

=head1 NAME

Qudo::Hook::Notify::Abort - notify abort.

=head1 SYNOPSIS

    $manager->register_hooks(qw/Qudo::Hook::Notify::Abort/);
    $manager->register_plugins(
        +{
            name => 'Qudo::Plugin::Logger',
            option => +{
                dispatchers => ['mail'],
                mail => {
                    class     => 'Log::Dispatch::Email::MIMELite',
                    min_level => 'debug',
                    to        => [ qw/alert@example.com/ ],
                    from      => 'alert@example.com',
                    subject   => 'qudo error!',
                    format    => "[%p] %m\n",
                    buffered  => 0,
                },
            },
        }
    );

=head1 DESCRIPTION

Qudo::Hook::Notify::Abort is notify abort. use Qudo::Plugin::Logger.

=head1 AUTHOR

Atsushi Kobayashi E<lt>nekokak _at_ gmail _dot_ comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

