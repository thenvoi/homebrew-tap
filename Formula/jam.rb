class Jam < Formula
  desc "Bridge coding agents to the Band platform (band CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.4.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.15/jam-aarch64-apple-darwin.tar.xz"
      sha256 "c703e86ca1d798d611bd19c94aa213562e1298648dfa2e1e5555b6d59ab4b287"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.15/jam-x86_64-apple-darwin.tar.xz"
      sha256 "a4ca4eea10252552dd8fb2aa0e5c01a83ee48d2d79d16310f84ddc358c6a6205"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.15/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3e7a0cd46a6a513e7d73d73a2213cf7cab6546a6529fb1bbffd4c56680af9222"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.15/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d92caebea49096794bf55e086ecb9f938d7a725be4228d44cbcef1da907c07c"
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
