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

ActiveRecord::Schema.define(version: 2018_06_29_074723) do

  create_table "cards", force: :cascade do |t|
    t.integer "numero"
    t.integer "numeroSeguridad"
    t.date "vencimiento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "plate"
    t.integer "seats"
    t.string "brand"
    t.string "model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "viaje_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "birth_date"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "car_id"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_viajes", id: false, force: :cascade do |t|
    t.integer "viaje_id", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_users_viajes_on_user_id"
    t.index ["viaje_id"], name: "index_users_viajes_on_viaje_id"
  end

  create_table "viajes", force: :cascade do |t|
    t.string "origen"
    t.string "destino"
    t.date "fecha"
    t.time "hora"
    t.float "precio"
    t.integer "duracion"
    t.text "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "pasajero_id"
    t.integer "chofer_id"
    t.string "car_plate"
    t.integer "asientos_libres"
    t.integer "car_id"
    t.index ["car_id"], name: "index_viajes_on_car_id"
    t.index ["chofer_id"], name: "index_viajes_on_chofer_id"
    t.index ["pasajero_id"], name: "index_viajes_on_pasajero_id"
  end

end
