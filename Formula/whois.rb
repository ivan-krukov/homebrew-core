class Whois < Formula
  desc "Lookup tool for domain names and other internet resources"
  homepage "https://packages.debian.org/sid/whois"
  url "https://mirrors.kernel.org/debian/pool/main/w/whois/whois_5.2.15.tar.xz"
  sha256 "7a5a6b690bfc6360d92d9328adbe5c1f096a41f0d6548ce0df4aa664dcb37188"
  head "https://github.com/rfc1036/whois.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2f76c5338e4a2a6d4fa2a20937e410a634b7c4d7eb11a1ddab6a539c66b19440" => :sierra
    sha256 "ac5d8ca304855154b1f6bc8b068431bb0cb2d96c114c73153d63145ac747d608" => :el_capitan
    sha256 "6a364e35b236f85c81a5338fc27e89af7c90798ec0c8437654bfb57daf92417e" => :yosemite
    sha256 "23f610fe888bbc4abac40e3cfb7b3eea2be29d96c9fb94b60bca42cfe95bb098" => :x86_64_linux
  end

  def install
    system "make", "whois", *(["HAVE_ICONV=1", "whois_LDADD+=-liconv"] if OS.mac?)
    bin.install "whois"
    man1.install "whois.1"
  end

  def caveats; <<-EOS.undent
    Debian whois has been installed as `whois` and may shadow the
    system binary of the same name.
    EOS
  end

  test do
    system "#{bin}/whois", "brew.sh"
  end
end
