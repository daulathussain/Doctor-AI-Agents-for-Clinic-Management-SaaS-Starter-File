export type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[]

export interface Database {
  public: {
    Tables: {
      ai_settings: {
        Row: {
          clinic_id: string
          created_at: string | null
          faq: string | null
          id: string
          tone: string | null
          updated_at: string | null
          widget_color: string | null
        }
        Insert: {
          clinic_id: string
          created_at?: string | null
          faq?: string | null
          id?: string
          tone?: string | null
          updated_at?: string | null
          widget_color?: string | null
        }
        Update: {
          clinic_id?: string
          created_at?: string | null
          faq?: string | null
          id?: string
          tone?: string | null
          updated_at?: string | null
          widget_color?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "ai_settings_clinic_id_fkey"
            columns: ["clinic_id"]
            isOneToOne: true
            referencedRelation: "clinics"
            referencedColumns: ["id"]
          }
        ]
      }
      appointments: {
        Row: {
          appointment_date: string
          appointment_time: string
          clinic_id: string
          created_at: string | null
          id: string
          patient_id: string
          service_id: string
          status: Database["public"]["Enums"]["appointment_status"] | null
          updated_at: string | null
        }
        Insert: {
          appointment_date: string
          appointment_time: string
          clinic_id: string
          created_at?: string | null
          id?: string
          patient_id: string
          service_id: string
          status?: Database["public"]["Enums"]["appointment_status"] | null
          updated_at?: string | null
        }
        Update: {
          appointment_date?: string
          appointment_time?: string
          clinic_id?: string
          created_at?: string | null
          id?: string
          patient_id?: string
          service_id?: string
          status?: Database["public"]["Enums"]["appointment_status"] | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "appointments_clinic_id_fkey"
            columns: ["clinic_id"]
            isOneToOne: false
            referencedRelation: "clinics"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "fk_appointments_patient_clinic"
            columns: ["clinic_id", "patient_id"]
            isOneToOne: false
            referencedRelation: "patients"
            referencedColumns: ["clinic_id", "id"]
          },
          {
            foreignKeyName: "fk_appointments_service_clinic"
            columns: ["clinic_id", "service_id"]
            isOneToOne: false
            referencedRelation: "services"
            referencedColumns: ["clinic_id", "id"]
          }
        ]
      }
      clinics: {
        Row: {
          blocked_dates: Json | null
          created_at: string | null
          id: string
          name: string
          opening_hours: Json | null
          subdomain: string | null
          timezone: string | null
          updated_at: string | null
        }
        Insert: {
          blocked_dates?: Json | null
          created_at?: string | null
          id: string
          name: string
          opening_hours?: Json | null
          subdomain?: string | null
          timezone?: string | null
          updated_at?: string | null
        }
        Update: {
          blocked_dates?: Json | null
          created_at?: string | null
          id?: string
          name?: string
          opening_hours?: Json | null
          subdomain?: string | null
          timezone?: string | null
          updated_at?: string | null
        }
        Relationships: []
      }
      patients: {
        Row: {
          clinic_id: string
          created_at: string | null
          email: string
          id: string
          name: string
          phone: string | null
          updated_at: string | null
        }
        Insert: {
          clinic_id: string
          created_at?: string | null
          email: string
          id?: string
          name: string
          phone?: string | null
          updated_at?: string | null
        }
        Update: {
          clinic_id?: string
          created_at?: string | null
          email?: string
          id?: string
          name?: string
          phone?: string | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "patients_clinic_id_fkey"
            columns: ["clinic_id"]
            isOneToOne: false
            referencedRelation: "clinics"
            referencedColumns: ["id"]
          }
        ]
      }
      services: {
        Row: {
          clinic_id: string
          created_at: string | null
          duration: number
          id: string
          is_active: boolean | null
          name: string
          price: number
          updated_at: string | null
        }
        Insert: {
          clinic_id: string
          created_at?: string | null
          duration: number
          id?: string
          is_active?: boolean | null
          name: string
          price?: number
          updated_at?: string | null
        }
        Update: {
          clinic_id?: string
          created_at?: string | null
          duration?: number
          id?: string
          is_active?: boolean | null
          name?: string
          price?: number
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "services_clinic_id_fkey"
            columns: ["clinic_id"]
            isOneToOne: false
            referencedRelation: "clinics"
            referencedColumns: ["id"]
          }
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      appointment_status: "booked" | "confirmed" | "completed" | "cancelled" | "no_show"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}
