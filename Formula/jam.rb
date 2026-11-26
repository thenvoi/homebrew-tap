class Jam < Formula
  desc "Bridge coding agents to the Band platform (band CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.5.2/jam-aarch64-apple-darwin.tar.xz"
      sha256 "79a5fed0aba602b39656fc26b8ff232a708a92510a4e96301e003c05d7fa43e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.5.2/jam-x86_64-apple-darwin.tar.xz"
      sha256 "b241098a2ce294470b478312523816da897ca65c5270e6b4ce5dd48e55e614ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.5.2/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "15c78d81c46c42cbd281e02ee3b1ffe4354ec06b28c2a80a8cf2e5fb7af18985"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.5.2/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1aebc832522c01d30bb371237ce39362d477cef83823e07ecb3d68ee76587ba1"
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
