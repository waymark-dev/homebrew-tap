class Waymark < Formula
  desc "Local dev host: stable URLs, on-demand wakeups, local HTTPS"
  homepage "https://github.com/waymark-dev"
  url "https://github.com/waymark-dev/homebrew-tap/archive/refs/tags/v0.1.33.tar.gz"
  sha256 "9240b4571fda7b47f58a53df4661677760dada95d635f9badda53a2c163bd33f"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/waymark-dev/homebrew-tap/releases/download/v0.1.33"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "96c3ff50bad41907d6fed8993c462525d866391dd46e6bfb3e9864c34e9a8c42"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e9fa0ba21f85e7ae5799818ec785210f564e836c75e471a6fd5f3cbbb99bbf29"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "74fbe9e8f3cb091ce092563d22d03b2ca357746cc4a951113d141f451be50fd3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ca1f7f3598dc95b8b231e7d64d6b8fa80d509d5c962c55f2f33f71bafef0532e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "44db013cc102471e055b97c62145a8fc244fc7f65cb68fb981b664516e3c0b32"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "2bf880f4f89e21bbee64613a8a7e0f84703adb872957b482abbade478f6d8d2d"
    sha256 cellar: :any_skip_relocation, big_sur:        "6d5087c7e8fbf42ffc484b783b8eeffb36bd9e23cf464e76cee1a353d0700043"
    sha256 cellar: :any_skip_relocation, monterey:       "6d5087c7e8fbf42ffc484b783b8eeffb36bd9e23cf464e76cee1a353d0700043"
    sha256 cellar: :any_skip_relocation, ventura:        "64245148f6b47098e17bb461e93d792437dfbae17650e166a27c3e67d2f882c8"
    sha256 cellar: :any_skip_relocation, sonoma:         "7ddce321517d2d7f9b5cb4066ce247b1f10f17d2637a84ab5f21ee2f65603243"
    sha256 cellar: :any_skip_relocation, sequoia:        "f861be11ce02ec2bab316c4b36d9543667c09de6acda38fd6d3983093c36a39f"
    sha256 cellar: :any_skip_relocation, tahoe:          "f861be11ce02ec2bab316c4b36d9543667c09de6acda38fd6d3983093c36a39f"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/waymark-cli")
    system "cargo", "install", *std_cargo_args(path: "crates/waymark-daemon")
  end

  def post_install
    label = "network.gyorffy.waymark.daemon"
    target = "gui/#{Process.uid}/#{label}"
    return unless quiet_system("launchctl", "print", target)

    return if quiet_system("launchctl", "kickstart", "-k", target)

    opoo "Waymark was upgraded, but the running daemon was not restarted."
    opoo "Run `launchctl kickstart -k #{target}` to use the new version now."
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
