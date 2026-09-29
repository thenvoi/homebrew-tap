class Jam < Formula
  desc "Bridge coding agents to the Band platform (band CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.4.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.12/jam-aarch64-apple-darwin.tar.xz"
      sha256 "0eb3f30f5d7aa139f8056beacacc788d651f705b043489617a0ba37bfddf80b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.12/jam-x86_64-apple-darwin.tar.xz"
      sha256 "7e31996ff5fe919732b7b8c4efb6cbdb227c696fa9968d2b4159c915ac569325"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.12/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b70bd1c4d8fc66acbe0ec7b0bd943d22871434ee890d25b30fb46ff15955281f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.12/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "79c0b8483f1e6d26fb1fe80efb9ebac6e34f2979ca9f18dc359e84a7f30a89e1"
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
