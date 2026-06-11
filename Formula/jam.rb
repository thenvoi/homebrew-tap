class Jam < Formula
  desc "The jam CLI (`jam`) and daemon (`jamd`) — two binaries shipped together so the CLI can find and launch the daemon."
  homepage "https://github.com/thenvoi/homebrew-tap"
  version "0.2.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.0/jam-aarch64-apple-darwin.tar.xz"
    sha256 "f4f89a0188081028bf0a6c8108535e106c8ae9293fecc9064c9436c2a91c96cf"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.0/jam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "81b4afd06790eb7ba14762758725af134b09fc26cb6734729adaffd04a0cb744"
    end
    if Hardware::CPU.intel?
      url "https://github.com/thenvoi/homebrew-tap/releases/download/v0.2.0/jam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4fa34cdf0335f343ea53ff61bc8525230e3586ddafc5fee32a4203bb662d0df6"
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
