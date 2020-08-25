package Nginx::FastCgi::Cache;

use strict;
use warnings;
use nginx;
use Digest::MD5 qw(md5_hex);
use File::Find;

#
# Purge Nginx Cache
# @see https://github.com/qbus-agentur/nginx_cache/blob/master/Resources/Private/nginx_purge/purge.pm
#
sub purge {
    my $r = shift;
    my $path = $r->variable('purge_path');
    my $levels = $r->variable('purge_levels');
    my $cache_key = $r->variable('purge_cache_key');

    if ($r->request_method ne 'PURGE') {
        return DECLINED;
    }
    $r->send_http_header('text/plain');
    $r->status(200);

    if ($r->variable('purge_all') == 1) {
        # Make extra sure we don't delete the entire system (or at least those files writable by nginx)
        # in case of a possible configuration mistake (e.g. if $path is empty),
        # by searching for filenames with 32 chars.
        # TODO: Despite our 32 length check we should check $path to be something sensible
        File::Find::find(\&delete, $path);
        $r->print("Removed all cache files.\n");
        return OK;
    }

    my $digest = md5_hex($cache_key);
    my @levels = split(':', $levels);
    my $offset = 0;
    foreach my $level (@levels) {
        $offset += $level;
        $path .= '/' . substr($digest, -$offset, $level);
    }

    my $cachefile = $path . '/' . $digest;
    if (-f $cachefile) {
        unlink $cachefile;
        $r->print("Removed cache file ", $cachefile, ".\n");
    } else {
        $r->print("Cache file ", $cachefile, " for cache_key: ", $cache_key, " not found.\n");
    }

    return OK;
}

sub delete {
    -f && length == 32 && unlink
}

1;
__END__
