module Gitpaint
  context 'map data to commits' do
    context 'pad data' do
      it 'pads an empty row' do
        expect(Gitpaint.pad_row [1, 0, 1]).to eq (
          [1, 0, 1] + [0] * 49
        )
      end

      it 'adds blank rows' do
        grid = Gitpaint.pad_grid [[1, 0, 1, 0, 1, 1], [1]]
        expect(grid[0]).to eq [1, 0, 1, 0, 1, 1] + [0] * 46
        expect(grid[6]).to eq [0] * 52
      end
    end

    context 'scale commits' do
      it 'scales grid values' do
        allow(Config.instance.config).to receive(:scale_factor).and_return 2

        data = [[0, 1, 2, 1, 4, 5], [0, 1]]
        expect(Gitpaint.scale_commits data).to eq [
          [0, 2, 4, 2, 8, 10],
          [0, 2]
        ]
      end
    end

    context 'turn data into dates' do
      it 'handles a single datapoint' do
        Timecop.freeze '2018-09-22' do
          data = [[1]]
          expect(Gitpaint.data_to_dates data).to eq (
            {
              '2017-09-17' => 1
            }
          )
        end
      end

      it 'handles 2 datapoints' do
        Timecop.freeze '2018-09-22' do
          data = [[1, 1]]
          expect(Gitpaint.data_to_dates data).to eq (
            {
              '2017-09-17' => 1,
              '2017-09-24' => 1
            }
          )
        end
      end

      it 'handles richer data' do
        Timecop.freeze '1974-06-15' do
          data = [[0, 2, 2], [], [0, 1]]
          expect(Gitpaint.data_to_dates data).to eq (
            {
              '1973-06-17' => 2,
              '1973-06-19' => 1,
              '1973-06-24' => 2
            }
          )
        end
      end
    end

    context 'generate commits' do
      it 'generates a commit from a datestamp' do
        allow(Gitpaint::Config.instance.config).to receive(:username).and_return 'gitpaint'
        allow(Gitpaint::Config.instance.config).to receive(:email).and_return 'git@paint.com'

        expect(Gitpaint.make_commit '2018-09-23').to eq (
          "GIT_AUTHOR_NAME=gitpaint GIT_AUTHOR_EMAIL=git@paint.com GIT_AUTHOR_DATE=2018-09-23T12:00:00 GIT_COMMITTER_NAME=gitpaint GIT_COMMITTER_EMAIL=git@paint.com GIT_COMMITTER_DATE=2018-09-23T12:00:00 git commit --allow-empty -m 'The commit is a lie' > /dev/null"
        )
      end

      it 'generates a commit with a custom commit message' do
        allow(Gitpaint::Config.instance.config).to receive(:username).and_return 'gitpaint'
        allow(Gitpaint::Config.instance.config).to receive(:email).and_return 'git@paint.com'

        expect(Gitpaint.make_commit '1970-01-01', message: 'Fake commit').to eq (
          "GIT_AUTHOR_NAME=gitpaint GIT_AUTHOR_EMAIL=git@paint.com GIT_AUTHOR_DATE=1970-01-01T12:00:00 GIT_COMMITTER_NAME=gitpaint GIT_COMMITTER_EMAIL=git@paint.com GIT_COMMITTER_DATE=1970-01-01T12:00:00 git commit --allow-empty -m 'Fake commit' > /dev/null"
        )
      end
    end
  end
end
