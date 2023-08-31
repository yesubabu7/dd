package Medicine_Pac;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MedicineController {

	private Medicine_DAO medicine_dao;

	@Autowired
	public MedicineController(Medicine_DAO m) {
		medicine_dao = m;
	}

	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String listMedicines(Model model) {

		List<Medicine> medicines = medicine_dao.getAllMedicines();

		List<String> medicineNames = new ArrayList<>();
		for (Medicine medicine : medicines) {
			medicineNames.add(medicine.getMedicineName());
		}

		model.addAttribute("medicines", medicines);
		model.addAttribute("medicineNames", medicineNames);
		return "Medicine_Display"; // Return the view name for displaying the list
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateMedicine(@RequestParam("id") String id, @RequestParam("quantity") int quantity,
			@RequestParam("price") double price, Model model) {

		// Call the service to update the medicine record
		boolean a = medicine_dao.updated(Integer.parseInt(id), quantity, price);
		if (a) {
			// Retrieve the updated medicine data
			Medicine updatedMedicine = medicine_dao.getMedicineById(Integer.parseInt(id));
			// Add the updated medicine to the model
			model.addAttribute("updatedMedicine", updatedMedicine);

			// Redirect back to the page
			// Replace with the appropriate URL
		}
		return "updated_data";
	}

	@RequestMapping(value = "/adding", method = RequestMethod.POST)
	public String adddata(@RequestParam("selectedMedicineId") String name) {
		System.out.println("add data" + name);
		// Call the service to update the medicine record
		List<Medicine> da = medicine_dao.get_data(name);
		System.out.println(da);

		// Redirect back to the page
		return ""; // Replace with the appropriate URL
	




		
}













    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addMedicine(@RequestParam("medicineId") int medicineId,
                              @RequestParam("quantity") int quantity,
                              @RequestParam("price") double price) {
        
        // Here you can use the retrieved data as needed
        System.out.println("Selected Medicine ID: " + medicineId);
        System.out.println("Quantity: " + quantity);
        System.out.println("Price: " + price);

        // Perform necessary operations, such as saving the data to a database
        // ...

        return "redirect:/"; // Redirect to a relevant page after processing
    }
