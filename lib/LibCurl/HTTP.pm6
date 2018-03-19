use v6;

use LibCurl::Easy;
use JSON::Fast;

class LibCurl::HTTP is LibCurl::Easy
{
    method GET($URL, $filename?)
    {
        self.setopt(download => $filename) if $filename;
        self.setopt(:failonerror, :httpget, URL => $URL);
    }

    method HEAD($URL)
    {
        self.setopt(:failonerror, :nobody, URL => $URL);
    }

    method OPTIONS($URL)
    {
        self.setopt(:failonerror, customrequest => 'OPTIONS', URL => $URL);
    }

    method DELETE($URL)
    {
        self.setopt(:failonerror, customrequest => 'DELETE', URL => $URL);
    }

    method PUT($URL, $filename)
    {
        self.setopt(:failonerror, URL => $URL, upload => $filename);
    }

    method POST($URL, $content?)
    {
        self.setopt(postfields => $content) if $content;
        self.setopt(:failonerror, customrequest => 'POST', URL => $URL);
    }
}

# Modeled after https://github.com/zoffixznet/perl6-WWW
sub get($url, $filename?, *%opts) is export(:subs)
{
    CATCH { .fail }
    LibCurl::HTTP.new(|%opts).GET($url, $filename).perform.content;
}

sub post($url, %headers?, *%form) is export(:subs)
{
    CATCH { .fail }
    my $http = LibCurl::HTTP.new;
    $http.set-header(|%headers);
    my $postform = %form.pairs.map({ "$_.key()=$_.value()"}).join('&');
    $http.POST($url, $postform).perform.content;
}

sub jget(|c) is export(:subs)  { CATCH { .fail }; from-json get |c }

sub jpost(|c) is export(:subs) { CATCH { .fail }; from-json post |c }
