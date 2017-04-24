use v6;

use LibCurl::Easy;

class LibCurl::HTTP is LibCurl::Easy
{
    method GET($URL, $filename?)
    {
        self.setopt(download => $filename) if $filename;
        self.setopt(:httpget, URL => $URL);
    }

    method HEAD($URL)
    {
        self.setopt(:nobody, URL => $URL);
    }

    method DELETE($URL)
    {
        self.setopt(customrequest => 'DELETE', URL => $URL);
    }

    method PUT($URL, $filename)
    {
        self.setopt(URL => $URL, upload => $filename);
    }

    method POST($URL, $content?)
    {
        self.setopt(postfields => $content) if $content;
        self.setopt(URL => $URL);
    }
}
