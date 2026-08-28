class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.4.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.7/jam-aarch64-apple-darwin.tar.xz"
      sha256 "510b2dd971813c53eb3c4c2c1a03db8b277927ae1b17d9f21a9cffbdd0715961"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.7/jam-x86_64-apple-darwin.tar.xz"
      sha256 "12ce35b3eef055dbacf08fc9b09bd0e3d4406bfb7d527e4a4a904cba9dd25878"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.7/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c5c1723479234e6b6ab0421c52e3e891644550c71c27cbd01a75c529393a29e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.7/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5228274efdf08bde9a6657c728316fd59a09c8fa61beff4b39c54937e47c1561"
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
