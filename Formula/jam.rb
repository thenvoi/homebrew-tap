class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.2.6"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.6/jam-aarch64-apple-darwin.tar.xz"
    sha256 "9a0d5e7f4b70b13624e48a1449613e5180b582498cd9df043a5d80127a2f4734"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.6/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a87316a1300d57924dbeca3a9da394a3793822c0a4740d9dfba3103c392ba240"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.6/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f18f1d7d5fb5a08e7063ee3e1f69851877b18ed270f57b66ac26ef0cdec928ce"
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
