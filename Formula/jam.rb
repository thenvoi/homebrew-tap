class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.4.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.6/jam-aarch64-apple-darwin.tar.xz"
      sha256 "a078d023fb13b4e26a59bfb2bba24e7fcb883612eaf5b56b700100dac0112596"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.6/jam-x86_64-apple-darwin.tar.xz"
      sha256 "e066e3c7a6b91c5397dc763c22c15318f1d9ba7e665611de348e9edde6d450d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.6/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d06ab264ff7ee3fca5098af80843ef5bb02d4dd816251c4cbc2aa8f8b25742ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.6/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0bdcdef4620e9ac2e0c9a80c786e28e0f35a4f96a585d3655d84d8d4faca217e"
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
