class Inkscape < Formula
  desc "Professional vector graphics editor"
  homepage "https://inkscape.org/"
  url "https://gitlab.com/api/v4/projects/inkscape%2Finkscape/repository/archive.tar.bz2"

  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "boost-build" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "bdw-gc"
  depends_on "boost"
  depends_on "cairomm"
  depends_on "gettext"
  depends_on "glibmm"
  depends_on "gsl"
  depends_on "hicolor-icon-theme"
  depends_on "libsoup" # > 0.92.x
  depends_on "little-cms"
  depends_on "pango"
  depends_on "popt"
  depends_on "poppler"
  depends_on "potrace"

  depends_on "gtk+3"
  depends_on "gtkmm3"
  depends_on "gdl"

  if MacOS.version < :mavericks
    fails_with :clang do
      cause "inkscape's dependencies will be built with libstdc++ and fail to link."
    end
  end

  def install
    ENV.cxx11
    ENV.append "LDFLAGS", "-liconv"
    ENV.append "LDFLAGS", "-lpoppler"

    system "mkdir", "build"
    Dir.chdir("build")
    system "cmake", "..", *std_cmake_args, "-DWITH_GTK3_EXPERIMENTAL=1"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/inkscape", "-x"
  end
end
