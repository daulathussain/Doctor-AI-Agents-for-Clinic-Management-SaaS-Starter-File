-- Enable Row Level Security
ALTER TABLE clinics ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_settings ENABLE ROW LEVEL SECURITY;

-- Policies for clinics
CREATE POLICY "Clinics can view their own data" ON clinics
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Clinics can update their own data" ON clinics
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Clinics can insert their own data" ON clinics
  FOR INSERT WITH CHECK (auth.uid() = id);

CREATE POLICY "Clinics can delete their own data" ON clinics
  FOR DELETE USING (auth.uid() = id);


-- Policies for services
CREATE POLICY "Clinics can view their own services" ON services
  FOR SELECT USING (auth.uid() = clinic_id);

CREATE POLICY "Clinics can update their own services" ON services
  FOR UPDATE USING (auth.uid() = clinic_id);

CREATE POLICY "Clinics can insert their own services" ON services
  FOR INSERT WITH CHECK (auth.uid() = clinic_id);

CREATE POLICY "Clinics can delete their own services" ON services
  FOR DELETE USING (auth.uid() = clinic_id);


-- Policies for patients
CREATE POLICY "Clinics can view their own patients" ON patients
  FOR SELECT USING (auth.uid() = clinic_id);

CREATE POLICY "Clinics can update their own patients" ON patients
  FOR UPDATE USING (auth.uid() = clinic_id);

CREATE POLICY "Clinics can insert their own patients" ON patients
  FOR INSERT WITH CHECK (auth.uid() = clinic_id);

CREATE POLICY "Clinics can delete their own patients" ON patients
  FOR DELETE USING (auth.uid() = clinic_id);


-- Policies for appointments
CREATE POLICY "Clinics can view their own appointments" ON appointments
  FOR SELECT USING (auth.uid() = clinic_id);

CREATE POLICY "Clinics can update their own appointments" ON appointments
  FOR UPDATE USING (auth.uid() = clinic_id);

CREATE POLICY "Clinics can insert their own appointments" ON appointments
  FOR INSERT WITH CHECK (auth.uid() = clinic_id);

CREATE POLICY "Clinics can delete their own appointments" ON appointments
  FOR DELETE USING (auth.uid() = clinic_id);


-- Policies for ai_settings
CREATE POLICY "Clinics can view their own ai settings" ON ai_settings
  FOR SELECT USING (auth.uid() = clinic_id);

CREATE POLICY "Clinics can update their own ai settings" ON ai_settings
  FOR UPDATE USING (auth.uid() = clinic_id);

CREATE POLICY "Clinics can insert their own ai settings" ON ai_settings
  FOR INSERT WITH CHECK (auth.uid() = clinic_id);

CREATE POLICY "Clinics can delete their own ai settings" ON ai_settings
  FOR DELETE USING (auth.uid() = clinic_id);
