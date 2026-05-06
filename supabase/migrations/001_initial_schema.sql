-- Create extension for UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create Enum for Appointment Status
CREATE TYPE appointment_status AS ENUM ('booked', 'confirmed', 'completed', 'cancelled', 'no_show');

-- Create clinics table
CREATE TABLE clinics (
  id UUID PRIMARY KEY, -- Will link to auth.uid()
  name TEXT NOT NULL,
  subdomain TEXT UNIQUE,
  timezone TEXT DEFAULT 'UTC',
  opening_hours JSONB DEFAULT '{"monday": {"open": "09:00", "close": "17:00"}, "tuesday": {"open": "09:00", "close": "17:00"}, "wednesday": {"open": "09:00", "close": "17:00"}, "thursday": {"open": "09:00", "close": "17:00"}, "friday": {"open": "09:00", "close": "17:00"}, "saturday": null, "sunday": null}'::jsonb,
  blocked_dates JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Index for frequent lookups by subdomain
CREATE INDEX idx_clinics_subdomain ON clinics(subdomain);

-- Create services table
CREATE TABLE services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clinic_id UUID NOT NULL REFERENCES clinics(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  duration INTEGER NOT NULL CHECK (duration > 0), -- in minutes
  price NUMERIC NOT NULL DEFAULT 0 CHECK (price >= 0),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(clinic_id, id)
);

-- Create patients table
CREATE TABLE patients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clinic_id UUID NOT NULL REFERENCES clinics(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(clinic_id, email),
  UNIQUE(clinic_id, id)
);

-- Create appointments table
CREATE TABLE appointments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clinic_id UUID NOT NULL REFERENCES clinics(id) ON DELETE CASCADE,
  patient_id UUID NOT NULL,
  service_id UUID NOT NULL,
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL,
  status appointment_status DEFAULT 'booked',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  CONSTRAINT fk_appointments_patient_clinic FOREIGN KEY (clinic_id, patient_id) REFERENCES patients(clinic_id, id),
  CONSTRAINT fk_appointments_service_clinic FOREIGN KEY (clinic_id, service_id) REFERENCES services(clinic_id, id)
);

-- Indexes for frequent queries on appointments
CREATE INDEX idx_appointments_clinic_date ON appointments(clinic_id, appointment_date);
CREATE INDEX idx_appointments_patient ON appointments(patient_id);

-- Create ai_settings table
CREATE TABLE ai_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clinic_id UUID NOT NULL UNIQUE REFERENCES clinics(id) ON DELETE CASCADE,
  tone TEXT DEFAULT 'Professional',
  faq TEXT,
  widget_color TEXT DEFAULT '#000000',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
