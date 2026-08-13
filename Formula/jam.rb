class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.5/jam-aarch64-apple-darwin.tar.xz"
      sha256 "82538eefed760e35eafd6e21fdce60e5877f0c0c894a74e0a963af0c51bf8da9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.5/jam-x86_64-apple-darwin.tar.xz"
      sha256 "6680652711721f83f434400c289e932d4efa03fbfc399503f6cde885d91dd0d9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.5/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3ed03ca67aa1dfb2e803d1c2d6105428fad55a1bfe345379559fe75274174945"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.5/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f7947621e6cb5f12c25d0fe95d25671d882310e4304dca327788a929b88a28a"
    end
  end
  license "LicenseRef-Proprietary"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "jam", "jamd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jam", "jamd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jam", "jamd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jam", "jamd"
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
