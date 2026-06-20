class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.3.3/jam-aarch64-apple-darwin.tar.xz"
      sha256 "6d44fbdbb184c209cca1e1e5d68845632acf2fcb2d98b56b2eb5ac558cecd148"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.3.3/jam-x86_64-apple-darwin.tar.xz"
      sha256 "2e3c7d487441d9b725966304edf599025b3a61e733eee75e00e7e7f6aaac1dbe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.3.3/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "52cc7016a4adfc03ef88dc1e56e640123be2307a5c57408e2d830d32a4ce263c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.3.3/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "088fda007b64b70de87747631927cf3207e86c76c0d7285266bd37c2aa313585"
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
    bin.install "jam", "jamd" if OS.mac? && Hardware::CPU.arm?
    bin.install "jam", "jamd" if OS.mac? && Hardware::CPU.intel?
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
