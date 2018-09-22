RSpec.describe Gitpaint do
  it 'has a version number' do
    expect(Gitpaint::VERSION).not_to be nil
  end

  it 'finds the Sunday before 1 year ago' do
    {
      '2018-09-22' => '2017-09-17',
      '2017-01-01' => '2015-12-27'
    }.each_pair do |now, sunday|
      Timecop.freeze now do
        expect(Gitpaint.sunday_before_a_year_ago.iso8601).to eq sunday
      end
    end
  end
end
