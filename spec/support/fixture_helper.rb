# frozen_string_literal: true

module FixtureHelper # :nodoc:
  def fetch_fixture(path)
    File.open(path, 'r')
  end

  def artists_fixture_path(file)
    detect_fixture_file_path(fixtures_path.join('livefans', 'artists'), file)
  end

  def venues_fixture_path(file)
    detect_fixture_file_path(fixtures_path.join('livefans', 'venues'), file)
  end

  private

  def fixtures_path
    Pathname.new fixture_path
  end

  def detect_fixture_file_path(base, file)
    return base unless file
    base.join(file)
  end
end
