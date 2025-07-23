{ unstable, ... }:

{
  programs.vscode = {
    enable = true;
    package = unstable.vscode.fhsWithPackages (ps: with ps; [ rustup zlib openssl.dev pkg-config ]);
  };

}
