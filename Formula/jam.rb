class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.2.4"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.4/jam-aarch64-apple-darwin.tar.xz"
    sha256 "44126ca5a5201a2d4867e6e9a4d4f532618614d7d6ddbbba8ce464e3a9a7ce1a"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.4/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0f843be5a6ce6f194cfa5be4adf7c6c40543318c5c8f9b4d2822795836d32076"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.4/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7d4d322fc8ba71da8517e22ff3f63d3f44b61cfc581cd5229344c69bb7bb82ca"
    end
  end
  license "LicenseRef-Proprietary"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
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
    bin.install "jam", "jamd" if OS.mac? && Hardware::CPU.arm?
    bin.install "jam", "jamd" if OS.linux? && Hardware::CPU.arm?
    bin.install "jam", "jamd" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
