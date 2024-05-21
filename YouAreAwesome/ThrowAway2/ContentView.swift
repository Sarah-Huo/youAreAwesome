//
//  ContentView.swift
//  ThrowAway2
//
//  Created by Huo, Sarah Z on 1/11/24.
//
import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var messageString = "";
    @State private var imageString = "teddybear"
    @State private var imageName = ""
    @State private var imageNumber = 0
    @State private var indexNum = 0
    @State private var lastMessageNumber = -1
    @State private var lastImageNumber = -1
    @State private var lastSoundNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    @State private var soundIsOn = true
    
    var body: some View {
        VStack {
            Text(messageString)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
            //                .frame(height: 150)
                .frame(maxWidth:.infinity)
            //                .border(.orange, width: 1)
                .padding()
                .animation(.easeOut(duration: 0.15), value: messageString)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
                .shadow(radius:30)
                .padding()
                .animation(.default, value: messageString)
            Spacer()
            
            //            Image(systemName: imageString)
            //                .resizable()
            //                .scaledToFit()
            //                .padding()
            //                .padding()
            //                .background(LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
            //                .foregroundColor(.white)
            //                .cornerRadius(30)
            //                .padding()
            //
            //            Text("You have Skills!")
            //                .font(.largeTitle)
            //                .fontWeight(.black)
            //                .foregroundColor(.blue)
            //                .padding()
            //                .background(Color("PeachPink"))
            //                .cornerRadius(15)
            //
            //            Image(systemName: "speaker.wave.3", variableValue: 0.2)
            //                .resizable()
            //                .scaledToFit()
            //                .symbolRenderingMode(.multicolor)
            //                .padding()
            //                .background(Color(hue: 0.534, saturation: 0.12, brightness: 1.0))
            //                .cornerRadius(30)
            //                .shadow(radius: 30, x:20, y:20)
            //                .overlay(
            //                    RoundedRectangle(cornerRadius: 30)
            //                        .stroke(.teal, lineWidth: 1)
            //                )
            //                .foregroundStyle(.gray, .orange,.blue)
            //                .padding()
            //
            
            Spacer()
            //                Divider()
            //                    .background(.black)
            //                    .padding()
            //                    .frame(width: 150.0)
            //
            //                Rectangle()
            //                    .fill(.indigo)
            //                    .frame(width: geometry.size.width*(2/3), height:1)
            //                Button("Awesome") {
            //                    //                    This is the action performed when the butten is pressed
            //                    //                    imageString = "bird"
            //                    messageString = "You are Awesome!"
            //                }
            //                .buttonStyle(.borderedProminent)
            //                Spacer()
            //
            //                Button("Great"){
            //                    messageString = "You are Great!"
            //                }
            //                //                .foregroundColor(.orange)
            //                .buttonStyle(.borderedProminent)
            HStack{
                Text("Sound On:")
                
                Toggle("Sound On:", isOn: $soundIsOn)
                    .labelsHidden()
                    .onChange(of: soundIsOn) { _ in
                        if audioPlayer != nil && audioPlayer.isPlaying{
                            audioPlayer.stop()
                        }
                    }
                Spacer()
                
                Button("Show Message"){
                    var messages = ["You Are Awesome!","You are Great!","Fabulous? That's You!","You're doing Great!","Good Job!"]
                    
                    //                    imageName = "image\(imageNumber)"
                    //                    imageNumber = (imageNumber < 9 ? imageNumber + 1: 0)
                    //
                    //                    if indexNum < messages.count - 1{
                    //                        indexNum += 1
                    //                    }else{
                    //                        indexNum = 0
                    //                    }
                    //                    messageString = messages[indexNum]
                    lastMessageNumber =  nonRepeatingRandom(lastNumber: lastMessageNumber, upperBounds: messages.count-1)
                    lastImageNumber = nonRepeatingRandom(lastNumber: lastImageNumber, upperBounds: 9)
                    
                    messageString = messages[lastMessageNumber]
                    imageName = "image\(lastImageNumber)"
                    
                    if soundIsOn {
                        playSound(soundName: "sound\(lastSoundNumber)")
                    }
                    
                    func playSound(soundName: String){
                        var soundNumber: Int
                        repeat {
                            soundNumber = Int.random(in: 0...5)
                        } while lastSoundNumber == soundNumber
                        
                        lastSoundNumber = soundNumber
                        var soundName = "sound\(soundNumber)"
                        
                        
                        guard let soundFile = NSDataAsset(name: soundName) else {
                            print("😡 Could not read file named \(soundName)")
                            return
                        }
                        do {
                            audioPlayer = try AVAudioPlayer(data: soundFile.data)
                            audioPlayer.play()
                        }catch{
                            print("😡 ERROR:\(error.localizedDescription) creating audioPlayer.")
                        }
                        
                    }
                    func nonRepeatingRandom(lastNumber: Int, upperBounds: Int) -> Int{
                        var number:Int
                        repeat {
                            number = Int.random(in: 0...upperBounds)
                        } while number == lastNumber
                        return number
                    }
                    
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .tint(.accentColor)
        .padding()
    }
    //            .border(.orange, width: 1)
    
    //            ColorPicker("ColorPicker", selection: .constant(.red))
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
