use LibCurl::Easy;
use JSON::Fast;

class LibCurl::REST
{
    has LibCurl::Easy $.curl;
    has Str $.prefix;

    submethod BUILD(Str :$host = 'localhost',
                    Int :$port = 80,
                    :$!prefix = "http://$host:$port",
                    |opts)
    {
        $!curl = LibCurl::Easy.new(|opts)
    }

    multi method query(Str:D $url!, IO::Path:D $path!, |opts)
    {
        $!curl.upload($path.absolute);
        $.query($url, |opts)
    }

    multi method query(Str:D $url!, Str:D $str!, |opts)
    {
        $!curl.send($str.encode);
        $.query($url, |opts)
    }

    multi method query(Str:D $url!, Iterable:D $obj!, |opts)
    {
        $!curl.Content-Type('application/json');
        $!curl.send(to-json($obj, :!pretty));

        $.query($url, |opts)
    }

    multi method query(Str:D $url!, Blob:D $blob!, |opts)
    {
        $!curl.send($blob);
        $.query($url, |opts)
    }

    multi method query(Str:D $url!, Str:D :$method = 'GET', Bool :$bin, *%opts)
    {
        LEAVE .reset with $!curl;

        $!curl.setopt(URL => "$!prefix/$url", customrequest => $method, |%opts)
              .perform;

        my $content = do given $!curl.get-header('Content-Type')
        {
            when 'application/json'
            {
                try my $json = from-json($!curl.content || "null");
                $! ?? $!curl.content !! $json;
            }
            default { $bin ?? $!curl.buf !! $!curl.content }
        }

        $!curl.success ?? $content
                       !! $content ?? die $content
                                   !! die $!curl.statusline
    }

    method get(|opts)    { $.query(:method<GET>,    |opts) }
    method post(|opts)   { $.query(:method<POST>,   |opts) || True }
    method delete(|opts) { $.query(:method<DELETE>, |opts) || True }
    method put(|opts)    { $.query(:method<PUT>,    |opts) || True }

    method head(Str:D $url, |opts)
    {
        LEAVE .reset with $!curl;

        $!curl.setopt(URL => "$!prefix/$url", :nobody, |opts).perform;

        $!curl.success ?? $!curl.receiveheaders !! die $!curl.statusline;
    }
}
