class Jam < Formula
  desc "Bridge coding agents to the Band platform (band CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.4.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.13/jam-aarch64-apple-darwin.tar.xz"
      sha256 "13d2320a219a547e8e538b00d4bb1ac1e6ba652579c0df9e00b2268fd3463ca0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.13/jam-x86_64-apple-darwin.tar.xz"
      sha256 "b8b660f3b3cd2a4c5070eb04ec4ce2bc1f89a278c84e73e100405dd7a630d21a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.13/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0b4620f8e8450f6a3d22c975e3784b73fbae743098aa2070454f1df2872e236c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.13/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "634951d7f5e0e30dd1ab08c12738245e7d4ea92b9df35a09b863ae5bdc8cc28a"
    end
  end
  license "LicenseRef-Proprietary"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {
      band: [
        "jam",
      ],
    },
    "aarch64-unknown-linux-gnu": {
      band: [
        "jam",
      ],
    },
    "x86_64-apple-darwin":       {
      band: [
        "jam",
      ],
    },
    "x86_64-unknown-linux-gnu":  {
      band: [
        "jam",
      ],
    },
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "band", "jamd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "band", "jamd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "band", "jamd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "band", "jamd"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
