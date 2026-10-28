class Dewatermark < Formula
  desc "Remove a translucent watermark shared by a set of page images"
  homepage "https://github.com/dbenjaminmiller/dewatermark"
  url "https://github.com/dbenjaminmiller/dewatermark/archive/refs/tags/v1.1.tar.gz"
  sha256 "f04de8f844854c74d8e6a70a24c992446d0240ad2e6617218069046c5e0f5ad2"
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
