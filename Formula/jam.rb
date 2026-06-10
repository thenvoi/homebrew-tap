class Jam < Formula
  desc "The jam CLI (`jam`) and daemon (`jamd`) — two binaries shipped together so the CLI can find and launch the daemon."
  homepage "https://github.com/thenvoi/tjam"
  version "0.1.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/thenvoi/tjam/releases/download/v0.1.0/jam-aarch64-apple-darwin.tar.xz"
    sha256 "4c90b85622f67f6ee66d9f563ac4725e4c781fefbb1572c13fecec067d9e4789"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/tjam/releases/download/v0.1.0/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "37db3a79d4de013f570a29f6e7b3d334e37d0e7c0fcb1a3b95f61640b3bb51f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/tjam/releases/download/v0.1.0/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c38b476706dac33b3a00701f284d9cf6cf2ee2fdae0e1b0dc1ab475400b99d88"
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
