class Jam < Formula
  desc "Bridge coding agents to the Band platform (band CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.4.14"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.14/jam-aarch64-apple-darwin.tar.xz"
      sha256 "7680e562ef176f6341bb9b1aee4e3cd16bb969b2d13839fa8ad6b50516a01234"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.14/jam-x86_64-apple-darwin.tar.xz"
      sha256 "e9a2fae69f376e3185331da70ebd9a44b250b00599e3ba69511f6d4295e860b4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.14/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "36cfe08ae52acbec0d84dae6e9185bdff18aef58942246906f3a08d10882ebef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.14/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e113881f49c448765f234826e6c865a618b1ea87bec2066b5aba0a74605f7ce3"
    end
  end
  license "LicenseRef-Proprietary"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {
      band: [
        "jam",
      ],
    },
    "aarch64-unknown-linux-gnu": {
      band: [
        "jam",
      ],
    },
    "x86_64-apple-darwin":       {
      band: [
        "jam",
      ],
    },
    "x86_64-unknown-linux-gnu":  {
      band: [
        "jam",
      ],
    },
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
      bin.install "band", "jamd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "band", "jamd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "band", "jamd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "band", "jamd"
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
