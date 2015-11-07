# Sends notifications of meals that people have signed up for.
# Checks the DB to see when to send.
class MealReminderJob
  def perform
    meal_ids = Meal.ids_in_time_from_now(Settings.meal_reminder_lead_time.hours)

    if meal_ids.any?
      # Find all households for meals in the next N hours that have not yet been notified.
      signups = Signup.where(meal_id: meal_ids).where(notified: false).includes(household: :users)

      # Send emails
      signups.each do |signup|
        signup.household_users.each do |user|
          NotificationMailer.meal_reminder(user, signup).deliver_now
        end
        signup.update_attribute(:notified, true)
      end
    end
  end

  def max_attempts
    3
  end

  def error(job, exception)
    ExceptionNotifier.notify_exception(exception)
  end
end