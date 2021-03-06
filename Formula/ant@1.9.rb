class AntAT19 < Formula
  desc "Java build tool"
  homepage "https://ant.apache.org/"
  url "https://www.apache.org/dyn/closer.cgi?path=ant/binaries/apache-ant-1.9.8-bin.tar.bz2"
  sha256 "6edeaab09fc0bb1eeeb6b6be9c0e463813b073c40189f760e70c85fa288d5125"

  bottle do
    cellar :any_skip_relocation
    sha256 "3cc3cd6d67b5e3fe30bed9139dfdc7f3916415ba8a692c892221657e500a9148" => :sierra
    sha256 "3cc3cd6d67b5e3fe30bed9139dfdc7f3916415ba8a692c892221657e500a9148" => :el_capitan
    sha256 "3cc3cd6d67b5e3fe30bed9139dfdc7f3916415ba8a692c892221657e500a9148" => :yosemite
    sha256 "3b37a5d3859aa032b17dbc93616dd38b277a3722643eb61b5922a6794a412edc" => :x86_64_linux
  end

  keg_only :versioned_formula

  def install
    rm Dir["bin/*.{bat,cmd,dll,exe}"]
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/bin/*"]
    rm bin/"ant"
    (bin/"ant").write <<-EOS.undent
      #!/bin/sh
      #{libexec}/bin/ant -lib #{HOMEBREW_PREFIX}/share/ant "$@"
    EOS
  end

  test do
    (testpath/"build.xml").write <<-EOS.undent
      <project name="HomebrewTest" basedir=".">
        <property name="src" location="src"/>
        <property name="build" location="build"/>
        <target name="init">
          <mkdir dir="${build}"/>
        </target>
        <target name="compile" depends="init">
          <javac srcdir="${src}" destdir="${build}"/>
        </target>
      </project>
    EOS
    (testpath/"src/main/java/org/homebrew/AntTest.java").write <<-EOS.undent
      package org.homebrew;
      public class AntTest {
        public static void main(String[] args) {
          System.out.println("Testing Ant with Homebrew!");
        }
      }
    EOS
    system "#{bin}/ant", "compile"
  end
end
