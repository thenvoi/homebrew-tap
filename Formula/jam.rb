class Jam < Formula
  desc "Bridge coding agents to the Band platform (jam CLI + jamd daemon)"
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.4.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.4/jam-aarch64-apple-darwin.tar.xz"
      sha256 "2f362cdd5714290e36df7ed9fa21049f25ef3372903ae8750c43780fcfca6722"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.4/jam-x86_64-apple-darwin.tar.xz"
      sha256 "5ea16eaf021992991c890a4577dd83a99160d654a41b624017774f8cc9243981"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.4/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d45fee9eedd85e70deaefc274cfbac09f23a8b386901f8030f0a29431002f0a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.4.4/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "09e9315bf1d112ca0e5a810a2f2afa11a85975d6daa89936f4b30346cff2fb91"
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
