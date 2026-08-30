class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.4.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.8/jam-aarch64-apple-darwin.tar.xz"
      sha256 "ee84a8bfc85dde52519ad2c6d9cfa3d739b8b913a9c0967e3403553b1cb5a705"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.8/jam-x86_64-apple-darwin.tar.xz"
      sha256 "9aea1acf0fca0f6c88ef3704be3d1a8c04d0787b3529309354f23d8c6f7ba6e1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.8/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5b27ea2aba05e5be94d7236981704fef8ef065a5dbaca5dece02918849b5443d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.8/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a7b71b2778e6df2dd80b5eac537e94e420e615e6587bb73a365889092dd07d3"
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
