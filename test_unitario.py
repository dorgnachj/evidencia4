import unittest

class TestBiodigestor(unittest.TestCase):
    def setUp(self):
        self.biodigestor = TestBiodigestor(
            temperatura_optima_minima=35,
            temperatura_optima_maxima=40,
            ph_optimo_minimo=6.5,
            ph_optimo_maximo=7.5,
            cantidad_ideal_minima=100,
            cantidad_ideal_maxima=200
        )
        
    def test_controlar_temperatura_calefaccion(self):
        self.biodigestor.temperatura_actual = 30
        with self.assertLogs(level='INFO') as log:
            self.biodigestor.controlar_temperatura()
            self.assertIn("Activando calefacción.", log.output[0])
    
    def test_controlar_temperatura_enfriamiento(self):
        self.biodigestor.temperatura_actual = 45
        with self.assertLogs(level='INFO') as log:
            self.biodigestor.controlar_temperatura()
            self.assertIn("Activando enfriamiento.", log.output[0])

    def test_controlar_ph_base(self):
        self.biodigestor.ph_actual = 6.0
        with self.assertLogs(level='INFO') as log:
            self.biodigestor.controlar_ph()
            self.assertIn("Añadiendo base.", log.output[0])
    
    def test_controlar_ph_acido(self):
        self.biodigestor.ph_actual = 8.0
        with self.assertLogs(level='INFO') as log:
            self.biodigestor.controlar_ph()
            self.assertIn("Añadiendo ácido.", log.output[0])
    
    def test_controlar_alimentacion_activar(self):
        self.biodigestor.cantidad_material = 50
        with self.assertLogs(level='INFO') as log:
            self.biodigestor.controlar_alimentacion()
            self.assertIn("Activando suministro de material.", log.output[0])
    
    def test_controlar_alimentacion_desactivar(self):
        self.biodigestor.cantidad_material = 250
        with self.assertLogs(level='INFO') as log:
            self.biodigestor.controlar_alimentacion()
            self.assertIn("Desactivando suministro de material.", log.output[0])

if __name__ == '__main__':
    unittest.main()
