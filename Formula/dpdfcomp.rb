class Dpdfcomp < Formula
  desc "Compress PDF fonts and images"
  homepage "https://github.com/dbenjaminmiller/dpdfcomp"
  url "https://github.com/dbenjaminmiller/dpdfcomp/archive/refs/tags/v1.1.tar.gz"
  sha256 "69e800e45a31586a3d5ac8feade2751906fbe8d8d6c795c12bc7d19901174b8c"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "freetype"
  depends_on "jpeg-turbo"
  depends_on "leptonica"
  depends_on "libtiff"
  depends_on "openjpeg"
  depends_on "qpdf"
  depends_on "tbb"

  uses_from_macos "libxml2" => :build
  uses_from_macos "zlib"

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DDPDFCOMP_STATIC=OFF",
                    "-DDPDFCOMP_BUILD_CLI=ON",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"dpdfcomp", "--no-progress", "--linearize", test_fixtures("test.pdf"), "output.pdf"
    assert_path_exists testpath/"output.pdf"
    system Formula["qpdf"].opt_bin/"qpdf", "--check", "output.pdf"
    system Formula["qpdf"].opt_bin/"qpdf", "--check-linearization", "output.pdf"
  end
end
