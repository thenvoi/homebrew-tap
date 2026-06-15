class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.2.7"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.7/jam-aarch64-apple-darwin.tar.xz"
    sha256 "44f6df425c9a630241522dcb09c4bb085aa34519f676df75b6c1c568cde8f83b"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.7/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "335b1f80615a7069f137c0536229844bb45f84701e7f4c9660bad9ead4279a88"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.7/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cb8713af4f9efd2e2073d1b81851edcc60febe9e61702895eea6d5002ef77388"
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
