class Jam < Formula
  desc "The jam CLI (`jam`) and daemon (`jamd`) — two binaries shipped together so the CLI can find and launch the daemon."
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.1.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.1.0/jam-aarch64-apple-darwin.tar.xz"
    sha256 "caa75daf3c05d5d491f5c43e2a4a0f7572b8e3ca12e267acc89654a9e9c90f01"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.1.0/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "499a36114cbe14ecad82ee0c7a8b229c6deae9e9d863bc496ba526224d8ec18d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.1.0/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21e90a6e28a9678cb4de0b6dbe152b20cca93287263410a52b97948ac094c1b4"
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
