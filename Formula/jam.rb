class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.3.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.3.11/jam-aarch64-apple-darwin.tar.xz"
      sha256 "2c6b9ed3ba066d8eb885d883fe7ef512822e94f43d09ff65a665e1a27b19c032"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.3.11/jam-x86_64-apple-darwin.tar.xz"
      sha256 "3c3eb792a3f2700313bafead502349c8a214d479df6253b792fc32697ab3c9a6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.3.11/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "37850b57e685193ee14fa7580ecd93d376fd3b4e5127b3f58de3e20c44ee46f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.3.11/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "777ddec51311c90a0e35354130141f57677275eb8789d941002938cbc68afc1e"
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
