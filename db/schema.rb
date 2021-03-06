# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180106185212) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.decimal "balance_due", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "cluster_id", null: false
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.decimal "credit_limit", precision: 10, scale: 2
    t.decimal "current_balance", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "due_last_statement", precision: 10, scale: 2
    t.integer "household_id", null: false
    t.integer "last_statement_id"
    t.date "last_statement_on"
    t.decimal "total_new_charges", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "total_new_credits", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_accounts_on_cluster_id"
    t.index ["community_id", "household_id"], name: "index_accounts_on_community_id_and_household_id", unique: true
    t.index ["community_id"], name: "index_accounts_on_community_id"
    t.index ["household_id"], name: "index_accounts_on_household_id"
  end

  create_table "assignments", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.datetime "created_at", null: false
    t.integer "meal_id", null: false
    t.integer "reminder_count", default: 0, null: false
    t.string "role", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["cluster_id"], name: "index_assignments_on_cluster_id"
    t.index ["meal_id", "role", "user_id"], name: "index_assignments_on_meal_id_and_role_and_user_id", unique: true
    t.index ["meal_id"], name: "index_assignments_on_meal_id"
    t.index ["role"], name: "index_assignments_on_role"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "clusters", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", limit: 20, null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_clusters_on_name"
  end

  create_table "communities", id: :serial, force: :cascade do |t|
    t.string "abbrv", limit: 2
    t.integer "cluster_id"
    t.datetime "created_at", null: false
    t.string "name", limit: 20, null: false
    t.jsonb "settings"
    t.string "slug", null: false
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_communities_on_cluster_id"
    t.index ["name"], name: "index_communities_on_name", unique: true
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "attempts", default: 0, null: false
    t.datetime "created_at"
    t.datetime "failed_at"
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "locked_at"
    t.string "locked_by"
    t.integer "priority", default: 0, null: false
    t.string "queue"
    t.datetime "run_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "households", id: :serial, force: :cascade do |t|
    t.string "alternate_id"
    t.integer "cluster_id", null: false
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "deactivated_at"
    t.string "garage_nums"
    t.string "keyholders"
    t.string "name", limit: 50, null: false
    t.integer "unit_num"
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_households_on_cluster_id"
    t.index ["community_id", "name"], name: "index_households_on_community_id_and_name", unique: true
    t.index ["community_id"], name: "index_households_on_community_id"
    t.index ["deactivated_at"], name: "index_households_on_deactivated_at"
    t.index ["name"], name: "index_households_on_name"
  end

  create_table "invitations", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.integer "community_id", null: false
    t.integer "meal_id", null: false
    t.index ["cluster_id"], name: "index_invitations_on_cluster_id"
    t.index ["community_id", "meal_id"], name: "index_invitations_on_community_id_and_meal_id", unique: true
    t.index ["community_id"], name: "index_invitations_on_community_id"
    t.index ["meal_id"], name: "index_invitations_on_meal_id"
  end

  create_table "meal_costs", id: :serial, force: :cascade do |t|
    t.decimal "adult_meat", precision: 10, scale: 2
    t.decimal "adult_veg", precision: 10, scale: 2
    t.decimal "big_kid_meat", precision: 10, scale: 2
    t.decimal "big_kid_veg", precision: 10, scale: 2
    t.integer "cluster_id", null: false
    t.datetime "created_at", null: false
    t.decimal "ingredient_cost", precision: 10, scale: 2, null: false
    t.decimal "little_kid_meat", precision: 10, scale: 2
    t.decimal "little_kid_veg", precision: 10, scale: 2
    t.string "meal_calc_type"
    t.integer "meal_id", null: false
    t.string "pantry_calc_type"
    t.decimal "pantry_cost", precision: 10, scale: 2, null: false
    t.decimal "pantry_fee", precision: 10, scale: 2
    t.string "payment_method", null: false
    t.decimal "senior_meat", precision: 10, scale: 2
    t.decimal "senior_veg", precision: 10, scale: 2
    t.decimal "teen_meat", precision: 10, scale: 2
    t.decimal "teen_veg", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_meal_costs_on_cluster_id"
    t.index ["meal_id"], name: "index_meal_costs_on_meal_id"
  end

  create_table "meal_formulas", id: :serial, force: :cascade do |t|
    t.decimal "adult_meat", precision: 10, scale: 2
    t.decimal "adult_veg", precision: 10, scale: 2
    t.decimal "big_kid_meat", precision: 10, scale: 2
    t.decimal "big_kid_veg", precision: 10, scale: 2
    t.integer "cluster_id", null: false
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "deactivated_at"
    t.boolean "is_default", default: false, null: false
    t.decimal "little_kid_meat", precision: 10, scale: 2
    t.decimal "little_kid_veg", precision: 10, scale: 2
    t.string "meal_calc_type", null: false
    t.string "name", null: false
    t.string "pantry_calc_type", null: false
    t.decimal "pantry_fee", precision: 10, scale: 2, null: false
    t.boolean "pantry_reimbursement", default: false
    t.decimal "senior_meat", precision: 10, scale: 2
    t.decimal "senior_veg", precision: 10, scale: 2
    t.decimal "teen_meat", precision: 10, scale: 2
    t.decimal "teen_veg", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_meal_formulas_on_cluster_id"
    t.index ["community_id"], name: "index_meal_formulas_on_community_id"
    t.index ["deactivated_at"], name: "index_meal_formulas_on_deactivated_at"
  end

  create_table "meal_messages", id: :serial, force: :cascade do |t|
    t.text "body", null: false
    t.integer "cluster_id", null: false
    t.datetime "created_at", null: false
    t.string "kind", default: "normal", null: false
    t.integer "meal_id", null: false
    t.string "recipient_type", null: false
    t.integer "sender_id", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", id: :serial, force: :cascade do |t|
    t.text "allergens", default: "[]", null: false
    t.integer "capacity", null: false
    t.integer "cluster_id", null: false
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.integer "creator_id", null: false
    t.text "dessert"
    t.text "entrees"
    t.integer "formula_id", null: false
    t.text "kids"
    t.text "notes"
    t.datetime "served_at", null: false
    t.text "side"
    t.string "status", default: "open", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_meals_on_cluster_id"
    t.index ["creator_id"], name: "index_meals_on_creator_id"
    t.index ["formula_id"], name: "index_meals_on_formula_id"
    t.index ["served_at"], name: "index_meals_on_served_at"
  end

  create_table "old_credit_balances", id: false, force: :cascade do |t|
    t.decimal "balance", precision: 5, scale: 2
    t.integer "community_program_id", default: 2
    t.string "name", limit: 65
    t.integer "new_id"
    t.decimal "old_id", precision: 6
  end

  create_table "people_emergency_contacts", id: :serial, force: :cascade do |t|
    t.string "alt_phone"
    t.integer "cluster_id", null: false
    t.datetime "created_at", null: false
    t.string "email"
    t.integer "household_id"
    t.string "location", null: false
    t.string "main_phone", null: false
    t.string "name", null: false
    t.string "relationship", null: false
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_people_emergency_contacts_on_cluster_id"
    t.index ["household_id"], name: "index_people_emergency_contacts_on_household_id"
  end

  create_table "people_guardianships", id: :serial, force: :cascade do |t|
    t.integer "child_id"
    t.integer "cluster_id", null: false
    t.datetime "created_at", null: false
    t.integer "guardian_id"
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_people_guardianships_on_child_id"
    t.index ["cluster_id"], name: "index_people_guardianships_on_cluster_id"
    t.index ["guardian_id"], name: "index_people_guardianships_on_guardian_id"
  end

  create_table "people_pets", id: :serial, force: :cascade do |t|
    t.string "caregivers"
    t.integer "cluster_id", null: false
    t.string "color"
    t.datetime "created_at", null: false
    t.text "health_issues"
    t.integer "household_id", null: false
    t.string "name"
    t.string "species"
    t.datetime "updated_at", null: false
    t.string "vet"
    t.index ["cluster_id"], name: "index_people_pets_on_cluster_id"
    t.index ["household_id"], name: "index_people_pets_on_household_id"
  end

  create_table "people_vehicles", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.string "color"
    t.datetime "created_at", null: false
    t.integer "household_id"
    t.string "make"
    t.string "model"
    t.string "plate", limit: 10
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_people_vehicles_on_cluster_id"
    t.index ["household_id"], name: "index_people_vehicles_on_household_id"
  end

  create_table "reservation_guideline_inclusions", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.integer "resource_id", null: false
    t.integer "shared_guidelines_id", null: false
    t.index ["cluster_id"], name: "index_reservation_guideline_inclusions_on_cluster_id"
    t.index ["resource_id", "shared_guidelines_id"], name: "index_reservation_guideline_inclusions", unique: true
  end

  create_table "reservation_protocolings", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.datetime "created_at", null: false
    t.integer "protocol_id", null: false
    t.integer "resource_id", null: false
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_reservation_protocolings_on_cluster_id"
    t.index ["resource_id", "protocol_id"], name: "protocolings_unique", unique: true
  end

  create_table "reservation_protocols", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.time "fixed_end_time"
    t.time "fixed_start_time"
    t.boolean "general", default: false, null: false
    t.string "kinds"
    t.integer "max_days_per_year"
    t.integer "max_lead_days"
    t.integer "max_length_minutes"
    t.integer "max_minutes_per_year"
    t.string "other_communities"
    t.text "pre_notice"
    t.boolean "requires_kind"
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_reservation_protocols_on_cluster_id"
    t.index ["community_id"], name: "index_reservation_protocols_on_community_id"
  end

  create_table "reservation_resourcings", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.integer "meal_id", null: false
    t.integer "prep_time", null: false
    t.integer "resource_id", null: false
    t.integer "total_time", null: false
    t.index ["cluster_id"], name: "index_reservation_resourcings_on_cluster_id"
    t.index ["meal_id", "resource_id"], name: "index_reservation_resourcings_on_meal_id_and_resource_id", unique: true
  end

  create_table "reservation_shared_guidelines", id: :serial, force: :cascade do |t|
    t.text "body", null: false
    t.integer "cluster_id", null: false
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.string "name", limit: 64, null: false
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_reservation_shared_guidelines_on_cluster_id"
    t.index ["community_id"], name: "index_reservation_shared_guidelines_on_community_id"
  end

  create_table "reservations", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.datetime "created_at", null: false
    t.datetime "ends_at"
    t.string "kind"
    t.integer "meal_id"
    t.string "name", limit: 24, null: false
    t.text "note"
    t.integer "reserver_id", null: false
    t.integer "resource_id", null: false
    t.integer "sponsor_id"
    t.datetime "starts_at"
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_reservations_on_cluster_id"
    t.index ["meal_id"], name: "index_reservations_on_meal_id"
    t.index ["reserver_id"], name: "index_reservations_on_reserver_id"
    t.index ["resource_id"], name: "index_reservations_on_resource_id"
    t.index ["sponsor_id"], name: "index_reservations_on_sponsor_id"
    t.index ["starts_at"], name: "index_reservations_on_starts_at"
  end

  create_table "resources", id: :serial, force: :cascade do |t|
    t.string "abbrv", limit: 6
    t.integer "cluster_id", null: false
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "deactivated_at"
    t.string "default_calendar_view", default: "week", null: false
    t.text "guidelines"
    t.boolean "meal_hostable", default: false, null: false
    t.string "name", limit: 24, null: false
    t.string "photo_content_type"
    t.string "photo_file_name"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_resources_on_cluster_id"
    t.index ["community_id", "name"], name: "index_resources_on_community_id_and_name", unique: true
    t.index ["community_id"], name: "index_resources_on_community_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.string "name"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "signups", id: :serial, force: :cascade do |t|
    t.integer "adult_meat", default: 0, null: false
    t.integer "adult_veg", default: 0, null: false
    t.integer "big_kid_meat", default: 0, null: false
    t.integer "big_kid_veg", default: 0, null: false
    t.integer "cluster_id", null: false
    t.text "comments"
    t.datetime "created_at", null: false
    t.integer "household_id", null: false
    t.integer "little_kid_meat", default: 0, null: false
    t.integer "little_kid_veg", default: 0, null: false
    t.integer "meal_id", null: false
    t.boolean "notified", default: false, null: false
    t.integer "senior_meat", default: 0, null: false
    t.integer "senior_veg", default: 0, null: false
    t.integer "teen_meat", default: 0, null: false
    t.integer "teen_veg", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_signups_on_cluster_id"
    t.index ["household_id", "meal_id"], name: "index_signups_on_household_id_and_meal_id", unique: true
    t.index ["household_id"], name: "index_signups_on_household_id"
    t.index ["meal_id"], name: "index_signups_on_meal_id"
    t.index ["notified"], name: "index_signups_on_notified"
  end

  create_table "statements", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "cluster_id", null: false
    t.datetime "created_at", null: false
    t.date "due_on"
    t.decimal "prev_balance", precision: 10, scale: 2, null: false
    t.date "prev_stmt_on"
    t.boolean "reminder_sent", default: false, null: false
    t.decimal "total_due", precision: 10, scale: 2, null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_statements_on_account_id"
    t.index ["cluster_id"], name: "index_statements_on_cluster_id"
    t.index ["created_at"], name: "index_statements_on_created_at"
    t.index ["due_on"], name: "index_statements_on_due_on"
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.integer "cluster_id", null: false
    t.string "code", limit: 16, null: false
    t.datetime "created_at", null: false
    t.string "description", limit: 255, null: false
    t.date "incurred_on", null: false
    t.integer "quantity"
    t.integer "statement_id"
    t.integer "statementable_id"
    t.string "statementable_type", limit: 32
    t.decimal "unit_price", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["cluster_id"], name: "index_transactions_on_cluster_id"
    t.index ["code"], name: "index_transactions_on_code"
    t.index ["incurred_on"], name: "index_transactions_on_incurred_on"
    t.index ["statement_id"], name: "index_transactions_on_statement_id"
    t.index ["statementable_id", "statementable_type"], name: "index_transactions_on_statementable_id_and_statementable_type"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "allergies"
    t.string "alternate_id"
    t.date "birthdate"
    t.string "calendar_token"
    t.boolean "child", default: false, null: false
    t.integer "cluster_id", null: false
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.inet "current_sign_in_ip"
    t.datetime "deactivated_at"
    t.string "doctor"
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.boolean "fake", default: false
    t.string "first_name", null: false
    t.string "google_email"
    t.string "home_phone"
    t.integer "household_id", null: false
    t.date "joined_on"
    t.string "last_name", null: false
    t.datetime "last_sign_in_at"
    t.inet "last_sign_in_ip"
    t.text "medical"
    t.string "mobile_phone"
    t.string "photo_content_type"
    t.string "photo_file_name"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "preferred_contact"
    t.jsonb "privacy_settings", default: {}, null: false
    t.string "provider"
    t.datetime "remember_created_at"
    t.string "remember_token"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "school"
    t.integer "sign_in_count", default: 0, null: false
    t.string "uid"
    t.datetime "updated_at", null: false
    t.string "work_phone"
    t.index ["alternate_id"], name: "index_users_on_alternate_id"
    t.index ["cluster_id"], name: "index_users_on_cluster_id"
    t.index ["deactivated_at"], name: "index_users_on_deactivated_at"
    t.index ["google_email"], name: "index_users_on_google_email", unique: true
    t.index ["household_id"], name: "index_users_on_household_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "wiki_page_versions", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.string "comment"
    t.text "content"
    t.integer "number", null: false
    t.integer "page_id", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "updator_id", null: false
    t.index ["cluster_id"], name: "index_wiki_page_versions_on_cluster_id"
    t.index ["page_id", "number"], name: "index_wiki_page_versions_on_page_id_and_number", unique: true
    t.index ["page_id"], name: "index_wiki_page_versions_on_page_id"
    t.index ["updator_id"], name: "index_wiki_page_versions_on_updator_id"
  end

  create_table "wiki_pages", id: :serial, force: :cascade do |t|
    t.integer "cluster_id", null: false
    t.integer "community_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "creator_id", null: false
    t.text "data_source"
    t.string "editable_by", default: "everyone", null: false
    t.string "role"
    t.string "slug", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "updator_id", null: false
    t.index ["cluster_id"], name: "index_wiki_pages_on_cluster_id"
    t.index ["community_id", "slug"], name: "index_wiki_pages_on_community_id_and_slug", unique: true
    t.index ["community_id", "title"], name: "index_wiki_pages_on_community_id_and_title", unique: true
    t.index ["community_id"], name: "index_wiki_pages_on_community_id"
    t.index ["creator_id"], name: "index_wiki_pages_on_creator_id"
    t.index ["updator_id"], name: "index_wiki_pages_on_updator_id"
  end

  add_foreign_key "accounts", "clusters"
  add_foreign_key "accounts", "communities"
  add_foreign_key "accounts", "households"
  add_foreign_key "accounts", "statements", column: "last_statement_id"
  add_foreign_key "assignments", "clusters"
  add_foreign_key "assignments", "meals"
  add_foreign_key "assignments", "users"
  add_foreign_key "communities", "clusters"
  add_foreign_key "households", "clusters"
  add_foreign_key "households", "communities"
  add_foreign_key "invitations", "clusters"
  add_foreign_key "invitations", "communities"
  add_foreign_key "invitations", "meals"
  add_foreign_key "meal_costs", "clusters"
  add_foreign_key "meal_costs", "meals"
  add_foreign_key "meal_formulas", "clusters"
  add_foreign_key "meal_formulas", "communities"
  add_foreign_key "meals", "clusters"
  add_foreign_key "meals", "communities"
  add_foreign_key "meals", "meal_formulas", column: "formula_id"
  add_foreign_key "meals", "users", column: "creator_id"
  add_foreign_key "people_emergency_contacts", "clusters"
  add_foreign_key "people_emergency_contacts", "households"
  add_foreign_key "people_guardianships", "clusters"
  add_foreign_key "people_pets", "clusters"
  add_foreign_key "people_pets", "households"
  add_foreign_key "people_vehicles", "clusters"
  add_foreign_key "people_vehicles", "households"
  add_foreign_key "reservation_guideline_inclusions", "clusters"
  add_foreign_key "reservation_guideline_inclusions", "reservation_shared_guidelines", column: "shared_guidelines_id"
  add_foreign_key "reservation_guideline_inclusions", "resources"
  add_foreign_key "reservation_protocolings", "clusters"
  add_foreign_key "reservation_protocolings", "reservation_protocols", column: "protocol_id"
  add_foreign_key "reservation_protocolings", "resources"
  add_foreign_key "reservation_protocols", "clusters"
  add_foreign_key "reservation_protocols", "communities"
  add_foreign_key "reservation_resourcings", "clusters"
  add_foreign_key "reservation_resourcings", "meals"
  add_foreign_key "reservation_resourcings", "resources"
  add_foreign_key "reservation_shared_guidelines", "clusters"
  add_foreign_key "reservation_shared_guidelines", "communities"
  add_foreign_key "reservations", "clusters"
  add_foreign_key "reservations", "meals"
  add_foreign_key "reservations", "resources"
  add_foreign_key "reservations", "users", column: "reserver_id"
  add_foreign_key "reservations", "users", column: "sponsor_id"
  add_foreign_key "resources", "clusters"
  add_foreign_key "resources", "communities"
  add_foreign_key "signups", "clusters"
  add_foreign_key "signups", "households"
  add_foreign_key "signups", "meals"
  add_foreign_key "statements", "accounts"
  add_foreign_key "statements", "clusters"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "clusters"
  add_foreign_key "transactions", "statements"
  add_foreign_key "users", "clusters"
  add_foreign_key "users", "households"
  add_foreign_key "users_roles", "roles"
  add_foreign_key "users_roles", "users"
  add_foreign_key "wiki_page_versions", "clusters"
  add_foreign_key "wiki_page_versions", "users", column: "updator_id"
  add_foreign_key "wiki_page_versions", "wiki_pages", column: "page_id"
  add_foreign_key "wiki_pages", "clusters"
  add_foreign_key "wiki_pages", "communities"
  add_foreign_key "wiki_pages", "users", column: "creator_id"
  add_foreign_key "wiki_pages", "users", column: "updator_id"
end
