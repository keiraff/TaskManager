# frozen_string_literal: true

RSpec.describe EmailNotifications::Update do
  subject(:service) do
    described_class.new(event_id: event.id, user_id: user.id, notify_at: event.notify_at,
                        job_id: event.notification_job_id)
  end

  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  context "when no notification set" do
    context "with notify_at" do
      let(:event) { create(:event, user: user, category: category, notify_at: 1.hour.from_now) }

      it "returns new notification job id" do
        expect { service.call }.to change(SendNotificationJob.jobs, :size).by(1)

        expect(service.success?).to be(true)
        expect(service.value).to eq(SendNotificationJob.jobs.last["jid"])
      end
    end

    context "without notify_at" do
      let(:event) { create(:event, user: user, category: category) }

      it "returns nil" do
        expect { service.call }.not_to change(SendNotificationJob.jobs, :size)

        expect(service.success?).to be(true)
        expect(service.value).to be_nil
      end
    end
  end

  context "when notification set" do
    let(:scheduled_job) { SendNotificationJob.perform_at(1.second.from_now) }

    before do
      Sidekiq::Testing.disable! do
        scheduled_job
      end
    end

    context "with notify_at" do
      let(:event) do
        create(:event, user: user, category: category, notify_at: 1.hour.from_now, notification_job_id: scheduled_job)
      end

      it "returns new notification job id" do
        expect { service.call }.to change(SendNotificationJob.jobs, :size).by(1)

        expect(service.success?).to be(true)
        expect(service.value).to eq(SendNotificationJob.jobs.last["jid"])
      end
    end

    context "without notify_at" do
      let(:event) { create(:event, user: user, category: category, notification_job_id: scheduled_job) }

      it "returns nil" do
        expect { service.call }.not_to change(SendNotificationJob.jobs, :size)

        expect(service.success?).to be(true)
        expect(service.value).to be_nil
      end
    end
  end
end
