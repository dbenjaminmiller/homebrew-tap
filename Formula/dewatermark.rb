class Dewatermark < Formula
  desc "Remove a translucent watermark shared by a set of page images"
  homepage "https://github.com/dbenjaminmiller/dewatermark"
  url "https://github.com/dbenjaminmiller/dewatermark/archive/refs/tags/v1.0.tar.gz"
  sha256 "2aec8a136e90a05648adb36447c92c2cd95f922365fb89acdb858683ea0afea6"
  license "0BSD"

  depends_on "pkgconf" => :build
  depends_on "opencv"

  def install
    system "make", "build/dewatermark"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "dewatermark version #{version}", shell_output("#{bin}/dewatermark --help")
    assert_match "no images", shell_output("#{bin}/dewatermark #{testpath} 2>&1", 1)
  end
end
