class Jam < Formula
  desc "The jam CLI (`jam`) and daemon (`jamd`) — two binaries shipped together so the CLI can find and launch the daemon."
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.2.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.1/jam-aarch64-apple-darwin.tar.xz"
    sha256 "3aa97448b8f4cf99b5852e3a8aef1915e8402761b248e3c26a70310692b23102"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.1/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d72dc01a8ff576d4ea8c2743288155e129f0ea594e736b0a5dccdc804e8451c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.1/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fe616555e79c467d4dc45533b6eab5c9a8cb0b21696649c271d729367c889d10"
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
