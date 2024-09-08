class Biodigestor:
    def __init__(self, temperatura_optima_minima, temperatura_optima_maxima, ph_optimo_minimo, ph_optimo_maximo, cantidad_ideal_minima, cantidad_ideal_maxima):
        self.temperatura_optima_minima = temperatura_optima_minima
        self.temperatura_optima_maxima = temperatura_optima_maxima
        self.ph_optimo_minimo = ph_optimo_minimo
        self.ph_optimo_maximo = ph_optimo_maximo
        self.cantidad_ideal_minima = cantidad_ideal_minima
        self.cantidad_ideal_maxima = cantidad_ideal_maxima
        
        self.temperatura_actual = None
        self.ph_actual = None
        self.cantidad_material = None

    def leer_sensor_temperatura(self):
        # Simulación de lectura del sensor
        return self.temperatura_actual

    def leer_sensor_ph(self):
        # Simulación de lectura del sensor
        return self.ph_actual

    def leer_sensor_nivel(self):
        # Simulación de lectura del sensor
        return self.cantidad_material

    def activar_calefaccion(self):
        print("Activando calefacción.")

    def activar_enfriamiento(self):
        print("Activando enfriamiento.")

    def añadir_base(self):
        print("Añadiendo base.")

    def añadir_acido(self):
        print("Añadiendo ácido.")

    def activar_suministro_material(self):
        print("Activando suministro de material.")

    def desactivar_suministro_material(self):
        print("Desactivando suministro de material.")

    def controlar_temperatura(self):
        temperatura = self.leer_sensor_temperatura()
        if temperatura < self.temperatura_optima_minima:
            self.activar_calefaccion()
        elif temperatura > self.temperatura_optima_maxima:
            self.activar_enfriamiento()

    def controlar_ph(self):
        ph = self.leer_sensor_ph()
        if ph < self.ph_optimo_minimo:
            self.añadir_base()
        elif ph > self.ph_optimo_maximo:
            self.añadir_acido()

    def controlar_alimentacion(self):
        cantidad = self.leer_sensor_nivel()
        if cantidad < self.cantidad_ideal_minima:
            self.activar_suministro_material()
        elif cantidad > self.cantidad_ideal_maxima:
            self.desactivar_suministro_material()
