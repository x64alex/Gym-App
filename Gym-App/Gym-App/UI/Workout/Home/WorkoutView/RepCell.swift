import SwiftUI

struct RepCell: View {
    @Binding public var rep: Int
    @Binding public var weight: Int
    
    var setNumber = -1
    
//    init(rep:Int, weight:Int, setNumber: Int = 0) {
//        self.$rep = rep
//        self.setNumber = setNumber
//    }
    
    
    var body: some View {
        Text("Set \(setNumber):")
        TextField("Repetitions", value: $rep, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .frame(width: 25)
            .padding(0)
        Text(" reps")
            .padding(0)
        Spacer()
            .frame(width: 10)
        TextField("Weight", value: $weight, formatter: NumberFormatter())
            .frame(width: 25)
            .onChange(of: weight) { newValue in
                if newValue >= 100 {
                    weight = 99
                }
            }
            .keyboardType(.numberPad)
        Text(" kg")
    }
}

//struct RepCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RepCell()
//    }
//}
