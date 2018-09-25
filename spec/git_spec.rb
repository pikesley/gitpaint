module Gitpaint
  context 'git operations' do
    REPO = 'somerepo'

    # before :all do
    #   @start_dir = Dir.pwd
    #   @g = Git.init REPO
    # end
    #
    # after :all do
    #   Dir.chdir @start_dir
    #   FileUtils.rm_r REPO
    # end

    it 'creates commits' do
      data = [[1, 0, 1], [], [0, 1, 0]]
      [:nuke, :create, :push].each do |method|
        allow(Gitpaint).to receive(method)
      end

      Timecop.freeze '2018-01-15' do
        Gitpaint.paint data, REPO
        g = Git.open "/tmp/#{REPO}"
        log = g.log
        expect(log.map { |l| l.author.date.iso8601 }).to eq [
          '2017-01-29T12:00:00+00:00',
          '2017-01-29T12:00:00+00:00',
          '2017-01-24T12:00:00+00:00',
          '2017-01-24T12:00:00+00:00',
          '2017-01-15T12:00:00+00:00',
          '2017-01-15T12:00:00+00:00'
        ]

        expect(log.map { |l| l.committer.date.iso8601 }).to eq [
          '2017-01-29T12:00:00+00:00',
          '2017-01-29T12:00:00+00:00',
          '2017-01-24T12:00:00+00:00',
          '2017-01-24T12:00:00+00:00',
          '2017-01-15T12:00:00+00:00',
          '2017-01-15T12:00:00+00:00'
        ]
      end
    end
  end
end
