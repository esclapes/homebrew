require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class V < Formula
  homepage 'http://ansible.cc/'
  url 'https://github.com/ansible/ansible/archive/v0.9.tar.gz'
  version '0.9'
  sha1 '23c3b807dcf296002663c10b10c42c3885f1340f'

  def install
    # In order to install into the Cellar, the dir must exist and be in the PYTHONPATH.
    temp_site_packages = lib/which_python/'site-packages'
    mkdir_p temp_site_packages
    ENV['PYTHONPATH'] = temp_site_packages
    
    args = [
      "--no-user-cfg",
      "--verbose",
      "install",
      "--force",
      "--single-version-externally-managed",
      "--install-scripts=#{bin}",
      "--install-lib=#{temp_site_packages}",
      "--install-data=#{share}",
      "--install-headers=#{include}",
      "--record=installed-files.txt"
    ]

    system "python", "-s", "setup.py", *args
  end
  
  def which_python
    # Update this once we have something like [this](https://github.com/mxcl/homebrew/issues/11204)
    "python" + `python -c 'import sys;print(sys.version[:3])'`.strip
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test v`.
    system "false"
  end
end
