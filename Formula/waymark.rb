class Waymark < Formula
  desc "Local dev host: stable URLs, on-demand wakeups, local HTTPS"
  homepage "https://github.com/waymark-dev"
  url "https://github.com/waymark-dev/homebrew-tap/archive/refs/tags/v0.1.30.tar.gz"
  sha256 "b4fed860106030c0c9965a117fb2ed7217af6926a3113aea2dd3bcdc1fc98984"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/waymark-dev/homebrew-tap/releases/download/v0.1.30"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "aa554b609cd4610380b4ae5ee4acb0994a2339fd419c404855d25260c8d3997f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7b73283b9b3db488deab9f5bb714a27ff11e8f3214aff2c8d4c7a91d3bc8ca64"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7b73283b9b3db488deab9f5bb714a27ff11e8f3214aff2c8d4c7a91d3bc8ca64"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "aba3be84ee8e3453586a39e7af7b6aebe28d71117d1c325c14ed9c43b3475702"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "227cd02d70da26383350e6507b498a68aab03d07c2a2946ca451841bbac7f0a4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "227cd02d70da26383350e6507b498a68aab03d07c2a2946ca451841bbac7f0a4"
    sha256 cellar: :any_skip_relocation, big_sur:        "138351be7ae2493d828e3aa3e1d038cebdf6144c8f624ee953771a936162eea0"
    sha256 cellar: :any_skip_relocation, monterey:       "0606f822dc86e764dd17d7e93d0b51a74d07c0f512fb001c1d95a371a4aca8f7"
    sha256 cellar: :any_skip_relocation, ventura:        "af05d633d9f36d2a7ac5e21cbfe8b3aafd79de757ecf02281de965a1f20fc2f1"
    sha256 cellar: :any_skip_relocation, sonoma:         "55a883b5964dd911c1a137b29bd545f1cae72e4764c9a22768637efdc001caa9"
    sha256 cellar: :any_skip_relocation, sequoia:        "4d2a49d0eaa702bc05d2006e832034c47d2f8fc64096b912dee54fbfd431e382"
    sha256 cellar: :any_skip_relocation, tahoe:          "cf6e73e32ea730792c655338a3f86ef5e27a545303419c2511254b42dd81c644"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/waymark-cli")
    system "cargo", "install", *std_cargo_args(path: "crates/waymark-daemon")
  end

  service do
    run [opt_bin/"waymarkd"]
    keep_alive true
    log_path var/"log/waymark/waymarkd.log"
    error_log_path var/"log/waymark/waymarkd.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/waymark --version")
    assert_match version.to_s, shell_output("#{bin}/waymarkd --version")
  end
end
