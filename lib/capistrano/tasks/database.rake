namespace :db do
  %w(migrate create drop reset seed).each do |task_name|
    desc "execute rake task #{task_name}"
    task task_name do
      on roles(:app), in: :sequence, wait: 5 do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, "db:#{task_name}"
          end
        end
      end
    end
  end

  desc "execute rake task db:drop:all"
  task "drop:all" do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:#{"drop:all"}"
        end
      end
    end
  end

  desc "execute rake task reset env"
  task "recreate" do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          invoke "db:drop"
          invoke "db:create"
          invoke "db:migrate"
          invoke "db:seed"
        end
      end
    end
  end

  before "db:drop", "puma:stop"
  after "db:create", "puma:start"
end